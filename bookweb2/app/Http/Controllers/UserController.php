<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\User;
use App\Models\Role;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Gate;
use Illuminate\Support\Facades\Auth;

class UserController extends Controller
{
    function list(Request $request){
        if(!Gate::allows('user/list')) {
            return view('error-404/error-404');
        }

        $keyword= "";
        if($request->input('keyword')){
            $keyword=$request->input('keyword');
        };

        // $users = User::orderByRaw("id = '" . Auth::id() . "' DESC")
        //      ->orderByRaw("id ASC")
        //      ->simplePaginate(10);
        // return view('backend/admin/user/list',compact('users'));

        $users = User::where(function ($query) use ($keyword) {
            $query->where('name', 'LIKE', "%{$keyword}%")
                  ->orWhere('id', 'LIKE', "%{$keyword}%")
                  ->orWhere('phone', 'LIKE', "%{$keyword}%")
                  ->orWhere('email', 'LIKE', "%{$keyword}%")
                  ->orWhereHas('role', function ($query) use ($keyword) {
                    $query->where('name', 'LIKE', "%{$keyword}%");
                });
        })->orderByRaw("id = '" . Auth::id() . "' DESC")
        ->orderByRaw("id ASC")
        ->simplePaginate(10);
        return view('backend/admin/user/list',compact('users'));
    }

    // function searchuser(Request $request){
    //     if($request->ajax()){
    //         $data=User::where('id','LIKE','%'.$request->keyword.'%')
    //                 ->orWhere('name','LIKE','%'.$request->keyword.'%')
    //                 ->orWhere('email','LIKE','%'.$request->keyword.'%')
    //                 ->get();
    //     }
    // }

    function add(){
        if(!Gate::allows('user/add')) {
            return view('error-404/error-404');
        }

        $roles=Role::all();
        return view('backend/admin/user/add',compact('roles'));
    }

    function store(Request $request){
        if(!Gate::allows('user/add')) {
            return view('error-404/error-404');
        }

        $request->validate([
            'name' => 'required',
            'email' => 'required|email|unique:users',
            'password' => 'required|min:5|max:12',
            'phone' => 'required|min:10|max:10',
            'role_id' => 'required',
        ]);
    
        User::create([
            'id' => str_pad(rand(0, 999999), 6, '0', STR_PAD_LEFT),
            'name' => $request->name,
            'email' => $request->email,
            'password' => Hash::make($request->password),
            'phone' => $request->phone,
            'role_id' => $request->role_id,
        ]);
    
        return redirect('admin/user/list')->with('success', 'User added successfully');
    }

    function delete($id){
        if(!Gate::allows('user/delete')) {
            return view('error-404/error-404');
        }

        User::where('id',$id)->forceDelete();
        return redirect('admin/user/list')->with('success','User deleted successfully');

    }

    function edit($id) {
        if(!Gate::allows('user/edit')) {
            return view('error-404/error-404');
        }

        $roles = Role::all();
        // $faculties=Faculty::all();
        $user = User::where('id', $id)->first();
    
        return view('backend/admin/user/edit', compact('user', 'roles'));
    } 

    function update(Request $request, $id){
        if(!Gate::allows('user/edit')) {
            return view('error-404/error-404');
        }

        $request->validate([
            'name'=>'required',
            'email'=>'required|email',
            'password'=>'required', 
            'phone'=>'required|min:10|max:10',
            'role_id'=>'required',
        ]);
    
        User::where('id', $id)->update([
            'name'=>$request->name,
            'email'=>$request->email,
            'password'=>Hash::make($request->password), 
            'phone'=>$request->phone,
            'role_id' => $request->role_id,
        ]);
    
        return redirect('admin/user/list')->with('success','User updated successfully');
    }

}
