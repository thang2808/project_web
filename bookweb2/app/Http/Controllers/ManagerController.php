<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Gate;
use App\Models\Contribution;

class ManagerController extends Controller
{
    function list(Request $request)
    {
        if (!Gate::allows('allpost/list')) {
            return view('error-404/error-404');
        }
    
        $keyword = $request->input('keyword', '');
    
        $managers = Contribution::where(function ($query) use ($keyword) {
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
        })->simplePaginate(10);
    
        return view('backend/manager/post/list', compact('managers'));
    }
    
}
