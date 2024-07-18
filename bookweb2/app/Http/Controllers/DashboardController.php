<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use App\Models\Contribution;
use App\Models\Category;

class DashboardController extends Controller
{
    function show(Request $request){
        $role=Auth::user()->role_id ?? '';

        if($role=='1')
        {
            return view('backend/admin/dashboard');
        }
        else if ($role=='4')
        {
            $managerdashboard = Contribution::all();
            $categories = Category::all();
            return view('backend/manager/dashboard',compact('managerdashboard','categories'));
        }
        else if ($role=='2')
        {
            return view('backend/coordinator/dashboard');
        }
        else if ($role=='5')
        {
            $keyword= "";
            if($request->input('keyword')){
                $keyword=$request->input('keyword');
            };

            $studentdashboard = Contribution::where(function ($query) use ($keyword) {
                $query->where('id', 'LIKE', "%{$keyword}%")
                      ->orWhere('user_id', 'LIKE', "%{$keyword}%")
                      ->orWhere('faculty_coordinator_id', 'LIKE', "%{$keyword}%")
                      ->orWhere('name', 'LIKE', "%{$keyword}%")
                      ->orWhere('content', 'LIKE', "%{$keyword}%")
                      ->orWhere('status', 'LIKE', "%{$keyword}%")
                      ->orWhere('comment', 'LIKE', "%{$keyword}%");
            })
            ->orWhereHas('user', function ($query) use ($keyword) {
                $query->where('name', 'LIKE', "%{$keyword}%");
            })
            ->orWhereHas('faculty_coordinator', function ($query) use ($keyword) {
                $query->where('name', 'LIKE', "%{$keyword}%");
            })
            ->orWhereHas('semester', function ($query) use ($keyword) {
                $query->where('name', 'LIKE', "%{$keyword}%");
            })
            ->simplePaginate(10);
            // $studentdashboard=Contribution::all();
            return view('backend/student/dashboard',compact('studentdashboard'));
        }
        else if ($role=='6')
        {
            return view('backend/guest/dashboard');
        }
        else{
            return view('backend/guest/dashboard');
        }
    }

    function info($id){
        $welcomeinfo = Contribution::find($id);
        return view('studentinfo',compact('welcomeinfo'));
    }

    function markasread(Request $request){
        auth()->user()->unreadNotifications->when($request->input('id'), function ($query) use ($request) {
            return $query->where('id', $request->input('id'));
        })->markAsRead();
        
        return response()->json(['message' => 'Notification marked as read']);
    }
}
