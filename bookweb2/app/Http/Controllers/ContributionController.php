<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Faculty_Coordinator;
use App\Models\Contribution;
use App\Models\Category;
use App\Models\Semester;
use App\Models\Student;
use App\Models\User;
use ZipArchive;
use DateTime;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Gate;

use App\Notifications\EmailStudentAdd;
use App\Notifications\StudentSendEmailForCoordinator;
use App\Notifications\DatabaseStudentAdd;

use App\Notifications\EmailStudentDelete;
use App\Notifications\DatabaseStudentDelete;

use App\Notifications\EmailStudentEdit;
use App\Notifications\DatabaseStudentEdit;




class ContributionController extends Controller
{
    function show(Request $request){
        if(!Gate::allows('class/show')) {
            return view('error-404/error-404');
        }

        $keyword= "";
        if($request->input('keyword')){
            $keyword=$request->input('keyword');
        };

        $classes= Faculty_Coordinator::where(function ($query) use ($keyword){
            $query->where('id', 'LIKE', "%{$keyword}%")
                  ->orWhere('name', 'LIKE', "%{$keyword}%")
                  ->orWhere('semester_id', 'LIKE', "%{$keyword}%")
                  ->orWhere('user_id', 'LIKE', "%{$keyword}%")

                  ->orWhereHas('semester', function ($query) use ($keyword) {
                    $query->where('name', 'LIKE', "%{$keyword}%");
                   })
                  ->orWhereHas('user', function ($query) use ($keyword) {
                    $query->where('name', 'LIKE', "%{$keyword}%");
                   });

        })->simplePaginate(10);


        // $classes= Faculty_Coordinator::all();
        return view('backend/student/class/list',compact('classes'));
    }

    function contributionlist(Faculty_Coordinator $faculty_coordinator, Request $request){
        if(!Gate::allows('class/contributionlist')) {
            return view('error-404/error-404');
        }

        $keyword= "";
        if($request->input('keyword')){
            $keyword=$request->input('keyword');
        };

        $contributions =Contribution::where(function ($query) use ($keyword){
            $query->where('name', 'LIKE', "%{$keyword}%")
                  ->orwhere('id', 'LIKE', "%{$keyword}%")
                  ->orWhere('content', 'LIKE', "%{$keyword}%")
                  ->orWhere('status', 'LIKE', "%{$keyword}%")
                  ->orWhere('comment', 'LIKE', "%{$keyword}%")
                  ->orWhere('popular', 'LIKE', "%{$keyword}%")
                  ->orWhere('created_at', 'LIKE', "%{$keyword}%")
                  ->orWhere('updated_at', 'LIKE', "%{$keyword}%");
        })->where('faculty_coordinator_id', $faculty_coordinator->id)->simplePaginate(10);
        // Get contributions for the specified class
        // $contributions = Contribution::where('faculty_coordinator_id', $faculty_coordinator->id)
        // ->where('user_id', Auth::id())
        // ->simplepaginate(10);

        return view('backend/student/contribution/list', compact('contributions','faculty_coordinator'));

    }

    function contributionadd(Faculty_Coordinator $faculty_coordinator)
    {
        if(!Gate::allows('class/contributionadd')) {
            return view('error-404/error-404');
        }
        $categories= Category::all();
        return view('backend/student/contribution/add', compact('faculty_coordinator','categories'));
    }

    function contributionstore(Request $request, Faculty_Coordinator $faculty_coordinator)
    {
        if(!Gate::allows('class/contributionadd')) {
            return view('error-404/error-404');
        }
        // Retrieve the end_date of the class's semester
        $semesterEndDate = Semester::where('id', $faculty_coordinator->semester_id)->value('end_date');
    
        // Compare the current date with the end_date
        $currentDate = now();
        $endOfSemester = new DateTime($semesterEndDate);
        if ($currentDate > $endOfSemester) {
            return redirect('student/class/contributionadd/' . $faculty_coordinator->id)->with('error', 'Submissions are not allowed after the end of the semester !!!');
        }
    
        // Validate the request data
        $request->validate([
            'name' => 'required',
            'category_id' => 'required',
            'content' => 'required',
            'upload_file' => 'required|file|mimes:doc,docx,pdf',
            'upload_image' => 'required|image|mimes:jpeg,png,jpg,gif',
            'status' => 'required|in:pending,approved,rejected',
            'comment' => 'nullable',
            'popular' => 'nullable'
        ], [
            'status.required' => 'You must accept the terms and conditions',
            'status.in' => 'Invalid status'
        ]);
    
        // Handle file uploads
        $input = $request->all();
        if ($request->hasFile('upload_file')) {
            $file = $request->file('upload_file');
            $filename = $file->getClientOriginalName();
            $path = $file->move('uploads/file', $filename);
            $input['upload_file'] = 'uploads/file/' . $filename;
        }
        if ($request->hasFile('upload_image')) {
            $file = $request->file('upload_image');
            $filename = $file->getClientOriginalName();
            $path = $file->move('uploads/image', $filename);
            $input['thumbnail'] = 'uploads/image/' . $filename;
        }
    
        // Create the Contribution
        $input['faculty_coordinator_id'] = $faculty_coordinator->id; // Set faculty_id
        $input['semester_id'] = $faculty_coordinator->semester_id;
        $input['user_id'] = Auth::id();
        Contribution::create($input);
    
        // Insert student submission into students table
        Student::create([
            'user_id' => Auth::id(),
            'faculty_coordinator_id' => $faculty_coordinator->id
        ]);

        // Find the user associated with the contribution
        $user = User::find($input['user_id']);
        
        // Notify the user about the submission via email
        $user->notify(new EmailStudentAdd());
    
        // Notify the coordinator about the submission
        $coordinator = $faculty_coordinator->user; // Assuming the coordinator is associated with the class through the user_id field
        if ($coordinator) {
            $coordinator->notify(new DatabaseStudentAdd($user));
        }
        $coordinator->notify(new StudentSendEmailForCoordinator($user));
    
        // Redirect after successful submission
        return redirect('student/class/contributionlist/' . $faculty_coordinator->id)->with('success', 'Contribution added successfully');
    }

    function contributiondelete($class, Contribution $contribution)
    {
        if(!Gate::allows('class/contributiondelete')) {
            return view('error-404/error-404');
        }
        $contribution->Delete(); // Soft delete the contribution

        // Find the user associated with the contribution
        $user = User::find($contribution->user_id);
        $user->notify(new EmailStudentDelete());

        // Find the coordinator associated with the class
        $coordinator = Faculty_Coordinator::find($class)->user;
        $coordinator->notify(new DatabaseStudentDelete($user));
        $coordinator->notify(new StudentSendEmailForCoordinator($user));
        
        return redirect('student/class/contributionlist/' . $class)->with('success', 'Contribution deleted successfully');
    }

    function contributionedit(Faculty_Coordinator $faculty_coordinator, $id)
    {
        if(!Gate::allows('class/contributionedit')) {
            return view('error-404/error-404');
        }
        $contribution = Contribution::where('id', $id)
        ->where('faculty_coordinator_id', $faculty_coordinator->id)
        ->firstOrFail();
        $categories= Category::all();
        return view('backend/student/contribution/edit', compact('faculty_coordinator', 'contribution','categories'));
    }

    function contributionupdate(Request $request, Faculty_Coordinator $faculty_coordinator, $id)
    {
        if(!Gate::allows('class/contributionedit')) {
            return view('error-404/error-404');
        }
        $request->validate([
            'name' => 'required',
            'category_id' => 'required',
            'content' => 'required',
            'upload_file' => 'nullable|file|mimes:doc,docx', 
            'upload_image' => 'nullable|image|mimes:jpeg,png,jpg,gif', 
            'comment' => 'nullable',
            'popular' => 'nullable'
        ]);
    
        $contribution = Contribution::findOrFail($id); // Find the contribution by its id
    
        // Update contribution fields
        $contribution->name = $request->name;
        $contribution->category_id = $request->category_id;
        $contribution->content = $request->content;
    
        // Handle file uploads if provided
        if ($request->hasFile('upload_file')) {
            $file = $request->file('upload_file');
            $filename = time() . '_' . $file->getClientOriginalName();
            $path = $file->move('uploads/file', $filename);
            $contribution->upload_file = $path;
        }
    
        if ($request->hasFile('upload_image')) {
            $file = $request->file('upload_image');
            $filename = time() . '_' . $file->getClientOriginalName();
            $path = $file->move('uploads/image', $filename);
            $contribution->thumbnail = $path;
        }
    
        // Save the updated contribution
        $contribution->save();
    
        // Find the user associated with the contribution
        $user = User::find($contribution->user_id);
        // Notify the user about the submission update
        $user->notify(new EmailStudentEdit());
    
        // Find the coordinator associated with the class
        $coordinator = $faculty_coordinator->user; 
    
        // Send a notification to the coordinator
        if ($coordinator) {
            $coordinator->notify(new DatabaseStudentEdit($user));
        }
        $coordinator->notify(new StudentSendEmailForCoordinator($user));
    
        return redirect('student/class/contributionlist/' . $faculty_coordinator->id)->with('success', 'Contribution updated successfully');
    }

    function contributionaction(Request $request)
    {
        $selectedFiles = $request->input('list_check');

        $zip = new ZipArchive();
        $filename = 'download.zip'; 
        $zipFilePath = public_path($filename);
    
        if ($zip->open($zipFilePath, ZipArchive::CREATE) === TRUE) {
            foreach ($selectedFiles as $selectedFile) {
                $file = Contribution::findOrFail($selectedFile); 
                $zip->addFile(public_path($file->upload_file), basename($file->upload_file));
            }
            $zip->close();
        }
    
        return response()->download($zipFilePath, 'download.zip')->deleteFileAfterSend();
    }

    function viewfile(Contribution $contribution)
    {

        // Get the path to the Word file from the Contribution model
        $wordFilePath = public_path($contribution->upload_file);

        // Check if the Word file exists
        if (!file_exists($wordFilePath)) {
            abort(404, 'File not found');
        }

        // Return the Word file for download
        return response()->download($wordFilePath, $contribution->name . '.docx');
    }

    function info($id){
        $contribution=Contribution::find($id);
        return view('backend/student/contribution/info',compact('contribution'));

    }

    function historylist(Faculty_Coordinator $faculty_coordinator)
    {
        if(!Gate::allows('history/historylist')) {
            return view('error-404/error-404');
        }
        // Get contributions for the specified class
        $histories = Contribution::where('faculty_coordinator_id', $faculty_coordinator->id)
            ->where('user_id', Auth::id())
            ->withTrashed()
            ->get();
        // Return a view with the contributions and the class
        return view('backend/student/history/list', compact('histories'));
        // return view('student/history/list');
    }
    
    
    
}
