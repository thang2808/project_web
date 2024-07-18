<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\User;
use App\Models\Contribution;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Gate;
use App\Notifications\CoordinatorSendStudentByEmail;
use App\Notifications\CoordinatorSendByDatabase;
use App\Notifications\CoordinatorSendByEmail;

class PostController extends Controller
{
    function list(Request $request)
    {
        if(!Gate::allows('post/list')) {
            return view('error-404/error-404');
        }

        $keyword= "";
        if($request->input('keyword')){
            $keyword=$request->input('keyword');
        };

        $coordinator = Auth::user();

        $posts = Contribution::where(function ($query) use ($keyword) {
            $query->where('id', 'LIKE', "%{$keyword}%")
                  ->orWhere('user_id', 'LIKE', "%{$keyword}%")
                  ->orWhere('faculty_coordinator_id', 'LIKE', "%{$keyword}%")
                  ->orWhere('category_id', 'LIKE', "%{$keyword}%")
                  ->orWhere('name', 'LIKE', "%{$keyword}%")
                  ->orWhere('content', 'LIKE', "%{$keyword}%")
                  ->orWhere('status', 'LIKE', "%{$keyword}%")
                  ->orWhere('comment', 'LIKE', "%{$keyword}%")
                  ->orWhereHas('user', function ($query) use ($keyword) {
                      $query->where('name', 'LIKE', "%{$keyword}%");
                  })
                  ->orWhereHas('faculty_coordinator', function ($query) use ($keyword) {
                      $query->where('name', 'LIKE', "%{$keyword}%");
                  })
                  ->orWhereHas('category', function ($query) use ($keyword) {
                      $query->where('name', 'LIKE', "%{$keyword}%");
                  });
        })
        ->whereHas('faculty_coordinator', function ($query) use ($coordinator) {
            $query->where('user_id', $coordinator->id);
        })
        ->simplePaginate(10);
        
    
        // Retrieve contributions based on the coordinator's faculty_coordinator_id and student_id
        // $posts = Contribution::whereHas('faculty_coordinator', function ($query) use ($coordinator) {
        //     $query->where('user_id', $coordinator->id);
        // })->simplepaginate(10);
    
        return view('backend/coordinator/post/list', compact('posts'));
    }

    function edit($id){
        if(!Gate::allows('post/edit')) {
            return view('error-404/error-404');
        }

        $post = Contribution::find($id);
        $post_status = Contribution::all();
        return view('backend/coordinator/post/edit', compact('post','post_status'));
    }

    function update(Request $request, $id){
        if(!Gate::allows('post/edit')) {
            return view('error-404/error-404');
        }
        
        // Validate the incoming request data
        $request->validate([
            'status'=>'required',
            'comment'=>'nullable',
            'popular'=>'nullable'
        ]);
    
        // Find the contribution/post by its ID
        $post = Contribution::find($id);
    
        // Update the post's attributes with the new values from the request
        $post->status = $request->status;
        $post->comment = $request->comment;
        $post->popular = $request->popular;
        $post->save();
    
        // Find the student who submitted the post to the coordinator
        $user = User::find($post->user_id);
        
        // Find the coordinator who commented and approved the post
        $coordinator = Auth::user();
        
        //Send to Student
        $user->notify(new CoordinatorSendStudentByEmail($user));

        //Send to student with databse 
        $user->notify(new CoordinatorSendByDatabase($coordinator));
        
        // Redirect back to the coordinator's post list with a success message
        return redirect('coordinator/post/list')->with('success','Post updated successfully');
    }
    
}
