<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\User;
use App\Models\Semester;
use App\Models\Faculty_Coordinator;
use Illuminate\Support\Facades\Gate;

class Faculty_CoordinatorController extends Controller
{
    function list(Request $request){
        if(!Gate::allows('faculty/list')) {
            return view('error-404/error-404');
        }

        $keyword= "";
        if($request->input('keyword')){
            $keyword=$request->input('keyword');
        };

        $faculty_coordinator=Faculty_Coordinator::where(function ($query) use ($keyword) {
            $query->where('id', 'LIKE', "%{$keyword}%")
                  ->orWhere('user_id', 'LIKE', "%{$keyword}%")
                  ->orWhere('name', 'LIKE', "%{$keyword}%")
                  ->orWhere('semester_id', 'LIKE', "%{$keyword}%")
                  ->orWhereHas('user', function ($query) use ($keyword) {
                    $query->where('name', 'LIKE', "%{$keyword}%");
                })
                ->orWhereHas('semester', function ($query) use ($keyword) {
                    $query->where('name', 'LIKE', "%{$keyword}%");
                });
        })->simplePaginate(10);

        // $faculty_coordinator=Faculty_Coordinator::all();
        return view('backend/admin/faculty_coordinator/list',compact('faculty_coordinator'));
    }

    function add(){
        if(!Gate::allows('faculty/add')) {
            return view('error-404/error-404');
        }
        $users= User::whereHas('role', function ($query) {
            $query->where('name', 'COORDINATOR');
        })->get();
        $semesters = Semester::all();
        return view('backend/admin/faculty_coordinator/add',compact('users','semesters'));
    }

    function store(Request $request)
    {
        if(!Gate::allows('faculty/add')) {
            return view('error-404/error-404');
        }

        $request->validate([
            'name' => 'required',
            'user_id' => 'required|exists:users,id', 
            'semester_id' => 'required',
            'description' => 'nullable',
        ]);

        Faculty_Coordinator::create([
            'name' => $request->name,
            'user_id' => $request->user_id, 
            'semester_id' => $request->semester_id, 
            'description' => $request->description,
        ]);

        return redirect('admin/faculty/list')->with('success', 'Coordinator has been added to faculty successfully');  
    }

    function delete($id){
        if(!Gate::allows('faculty/delete')) {
            return view('error-404/error-404');
        }

        Faculty_Coordinator::find($id)->forceDelete();
        return redirect('admin/faculty/list')->with('success', 'Coordinator has been deleted from faculty successfully');
    }

    function edit($id){
        if(!Gate::allows('faculty/edit')) {
            return view('error-404/error-404');
        }

        $class=Faculty_Coordinator::find($id);
        $users= User::whereHas('role', function ($query) {
            $query->where('name', 'coordinator');
        })->get();
        $semesters = Semester::all();

        return view('backend/admin/faculty_coordinator/edit',compact('class','users','semesters'));
    }

    function update(Request $request, $id){
        if(!Gate::allows('faculty/edit')) {
            return view('error-404/error-404');
        }

        $request->validate([
            'name' => 'required',
            'description' => 'nullable',
            'user_id' => 'required', 
            'semester_id' => 'required',
        ]);
    
        Faculty_Coordinator::where('id', $id)->update([
            'name' => $request->name,
            'user_id' => $request->user_id,
            'semester_id' => $request->semester_id,
            'description' => $request->description, 
        ]);
        // return dd($request->all()); 
        return redirect('admin/faculty/list')->with('success', 'Coordinator has been updated to faculty successfully');
    }
}
