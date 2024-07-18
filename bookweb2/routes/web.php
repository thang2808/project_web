<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\DashboardController;
use App\Http\Controllers\UserController;
use App\Http\Controllers\PermissionController;
use App\Http\Controllers\RoleController;
use App\Http\Controllers\SemesterController;
use App\Http\Controllers\CategoryController;
use App\Http\Controllers\Faculty_CoordinatorController;
use App\Http\Controllers\ContributionController;
use App\Http\Controllers\PostController;
use App\Http\Controllers\ManagerController;

use App\Models\Student;
use App\Models\Contribution;
use App\Models\Faculty_Coordinator;
use App\Models\Post;
use App\Models\Role;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "web" middleware group. Make something great!
|
*/

Route::get('/', function () {

    $participants= Student::count();
    $contributions= Contribution::count();

    $popularstudent = Contribution::where('status', 'approved')
                               ->where('popular', '1')
                               ->get();
    $student= Contribution::where('status', 'approved')
                            ->simplePaginate(5);
    return view('welcome', compact('participants','contributions','popularstudent','student'));
});

Route::get('student/welcome/info/{id}',[DashboardController::class,'info'])->name('welcome/info');

Route::middleware([
    'auth:sanctum',
    config('jetstream.auth_session'),
    'verified',
])->group(function () {
    Route::get('/dashboard', function () {
        return view('dashboard');
    })->name('dashboard');
});


Route::middleware('auth')->group(function(){

//Admin
    //Dashboard
    Route::get('dashboard',[DashboardController::class,'show'])->name('dashboard');

    //Mark as read
    Route::post('/markasread', [DashboardController::class,'markasread']);

    //User
    Route::get('admin/user/list',[UserController::class,'list']);
    Route::get('admin/user/searchuser',[UserController::class,'searchuser']);
    Route::get('admin/user/add',[UserController::class,'add']);
    Route::post('admin/user/store',[UserController::class,'store']);
    Route::get('admin/user/edit/{id}', [UserController::class, 'edit'])->name('user/edit');
    Route::post('admin/user/update/{id}',[UserController::class,'update'])->name('user/update');
    Route::get('admin/user/delete/{id}',[UserController::class,'delete'])->name('user/delete');

    Route::get('/user/list',[UserController::class,'list'])->name('user/list')->can('user/list');
    Route::get('/user/add',[UserController::class,'add'])->name('user/add')->can('user/add');
    Route::post('/user/store',[UserController::class,'store'])->name('user/store')->can('user/add');
    Route::get('/user/edit/{id}',[UserController::class,'edit'])->name('user/edit')->can('user/edit');
    Route::post('/user/update/{id}',[UserController::class,'update'])->name('user/update')->can('user/edit');
    Route::get('/user/delete/{id}',[UserController::class,'delete'])->name('user/delete')->can('user/delete');

    //Permission
    Route::get('admin/permission/add',[PermissionController::class,'add']);
    Route::post('admin/permission/store',[PermissionController::class,'store']);
    Route::get('admin/permission/edit/{id}', [PermissionController::class, 'edit'])->name('permission/edit');
    Route::post('admin/permission/update/{id}',[PermissionController::class,'update'])->name('permission/update');
    Route::get('admin/permission/delete/{id}',[PermissionController::class,'delete'])->name('permission/delete');

    Route::get('/permission/add',[PermissionController::class,'add'])->name('permission/add')->can('permission/add');
    Route::post('/permission/store',[PermissionController::class,'store'])->name('permission/store')->can('permission/add');
    Route::get('/permission/edit/{id}',[PermissionController::class,'edit'])->name('permission/edit')->can('permission/edit');
    Route::post('/permission/update/{id}',[PermissionController::class,'update'])->name('permission/update')->can('permission/edit');
    Route::get('/permission/delete/{id}',[PermissionController::class,'delete'])->name('permission/delete')->can('permission/delete');

    //Role
    Route::get('admin/role/list',[RoleController::class,'list']);
    Route::get('admin/role/add',[RoleController::class,'add']);
    Route::post('admin/role/store',[RoleController::class,'store']);
    Route::get('admin/role/edit/{role}', [RoleController::class, 'edit'])->name('role/edit');
    Route::post('admin/role/update/{role}',[RoleController::class,'update'])->name('role/update');
    Route::get('admin/role/delete/{role}',[RoleController::class,'delete'])->name('role/delete');

    Route::get('/role',[RoleController::class,'list'])->name('role/list')->can('role/list');
    Route::get('/role/add',[RoleController::class,'add'])->name('role/add')->can('role/add');
    Route::post('/role/store',[RoleController::class,'store'])->name('role/store')->can('role/add');
    Route::get('/role/edit/{role}',[RoleController::class,'edit'])->name('role/edit')->can('role/edit');
    Route::post('/role/update/{role}',[RoleController::class,'update'])->name('role/update')->can('role/edit');
    Route::get('/role/delete/{role}',[RoleController::class,'delete'])->name('role/delete')->can('role/delete');

    //Semester
    Route::get('admin/semester/add',[SemesterController::class,'add']);
    Route::post('admin/semester/store',[SemesterController::class,'store']);
    Route::get('admin/semester/edit/{id}', [SemesterController::class, 'edit'])->name('semester/edit');
    Route::post('admin/semester/update/{id}',[SemesterController::class,'update'])->name('semester/update');
    Route::get('admin/semester/delete/{id}',[SemesterController::class,'delete'])->name('semester/delete');

    Route::get('/semester/add',[SemesterController::class,'add'])->name('semester/add')->can('semester/add');
    Route::post('/semester/store',[SemesterController::class,'store'])->name('semester/store')->can('semester/add');
    Route::get('/semester/edit/{id}',[SemesterController::class,'edit'])->name('semester/edit')->can('semester/edit');
    Route::post('/semester/update/{id}',[SemesterController::class,'update'])->name('semester/update')->can('semester/edit');
    Route::get('/semester/delete/{id}',[SemesterController::class,'delete'])->name('semester/delete')->can('semester/delete');

    //Category
    Route::get('admin/category/add',[CategoryController::class,'add']);
    Route::post('admin/category/store',[CategoryController::class,'store']);
    Route::get('admin/category/edit/{id}', [CategoryController::class, 'edit'])->name('category/edit');
    Route::post('admin/category/update/{id}',[CategoryController::class,'update'])->name('category/update');
    Route::get('admin/category/delete/{id}',[CategoryController::class,'delete'])->name('category/delete');

    Route::get('/category/add',[CategoryController::class,'add'])->name('category/add')->can('category/add');
    Route::post('/category/store',[CategoryController::class,'store'])->name('category/store')->can('category/add');
    Route::get('/category/edit/{id}',[CategoryController::class,'edit'])->name('category/edit')->can('category/edit');
    Route::post('/category/update/{id}',[CategoryController::class,'update'])->name('category/update')->can('category/edit');
    Route::get('/category/delete/{id}',[CategoryController::class,'delete'])->name('category/delete')->can('category/delete');

    //Faculty_Coordinator
    Route::get('admin/faculty/list',[Faculty_CoordinatorController::class,'list']);
    Route::get('admin/faculty/add',[Faculty_CoordinatorController::class,'add']);
    Route::post('admin/faculty/store',[Faculty_CoordinatorController::class,'store']);
    Route::get('admin/faculty/edit/{id}', [Faculty_CoordinatorController::class, 'edit'])->name('faculty/edit');
    Route::post('admin/faculty/update/{id}',[Faculty_CoordinatorController::class,'update'])->name('faculty/update');
    Route::get('admin/faculty/delete/{id}',[Faculty_CoordinatorController::class,'delete'])->name('faculty/delete');

    Route::get('/faculty/list',[Faculty_CoordinatorController::class,'list'])->name('faculty/list')->can('faculty/list');
    Route::get('/faculty/add',[Faculty_CoordinatorController::class,'add'])->name('faculty/add')->can('faculty/add');
    Route::post('/faculty/store',[Faculty_CoordinatorController::class,'store'])->name('faculty/store')->can('faculty/add');
    Route::get('/faculty/edit/{id}',[Faculty_CoordinatorController::class,'edit'])->name('faculty/edit')->can('faculty/edit');
    Route::post('/faculty/update/{id}',[Faculty_CoordinatorController::class,'update'])->name('faculty/update')->can('faculty/edit');
    Route::get('/faculty/delete/{id}',[Faculty_CoordinatorController::class,'delete'])->name('faculty/delete')->can('faculty/delete');

//Coordinator
    //Post
    Route::get('coordinator/post/list',[PostController::class,'list']);
    Route::get('coordinator/post/edit/{id}',[PostController::class,'edit'])->name('post/edit');
    Route::post('coordinator/post/update/{id}',[PostController::class,'update'])->name('post/update');

    Route::get('/post/list',[PostController::class,'list'])->name('post/list')->can('post/list');
    Route::get('/post/edit/{id}',[PostController::class,'edit'])->name('post/edit')->can('post/edit');

    //Download
    Route::post('coordinator/post/contributionaction',[ContributionController::class,'contributionaction'])->name('post/contributionaction');
    Route::get('coordinator/post/viewfile/{contribution}', [ContributionController::class, 'viewfile'])->name('post/viewfile');


//Student
    //Dashboard
    Route::get('dashboard/student/info/{id}',[ContributionController::class,'info'])->name('student/info');
    Route::get('dashboard/studentinfo/showfile/{contribution}', [ContributionController::class, 'viewfile'])->name('studentinfo/showfile');

    //Download
    Route::post('student/class/contributionaction',[ContributionController::class,'contributionaction'])->name('class/contributionaction');
    Route::get('student/class/viewfile/{contribution}', [ContributionController::class, 'viewfile'])->name('class/viewfile');

    //Contribution (Management)
    Route::get('student/class/show',[ContributionController::class,'show']);
    Route::get('student/class/contributionlist/{faculty_coordinator}', [ContributionController::class,'contributionlist'])->name('class/contributionlist');
    Route::get('student/class/contributionadd/{faculty_coordinator}',[ContributionController::class,'contributionadd'])->name('class/contributionadd');
    Route::post('student/class/contributionstore/{faculty_coordinator}',[ContributionController::class,'contributionstore'])->name('class/contributionstore');
    Route::get('student/class/contributionedit/{faculty_coordinator}/{contribution}',[ContributionController::class,'contributionedit'])->name('class/contributionedit');
    Route::post('student/class/contributionupdate/{faculty_coordinator}/{contribution}',[ContributionController::class,'contributionupdate'])->name('class/contributionupdate');
    Route::get('student/class/contributiondelete/{faculty_coordinator}/{contribution}',[ContributionController::class,'contributiondelete'])->name('class/contributiondelete');
    Route::get('student/history/historylist/{faculty_coordinator}',[ContributionController::class,'historylist'])->name('history/historylist');

    Route::get('/class/show',[ContributionController::class,'show'])->name('class/show')->can('class/show');
    Route::get('/class/contributionlist/{faculty_coordinator}',[ContributionController::class,'contributionlist'])->name('class/contributionlist')->can('class/contributionlist');
    Route::get('/class/contributionadd/{faculty_coordinator}',[ContributionController::class,'contributionadd'])->name('class/contributionadd')->can('class/contributionadd');
    Route::post('/class/contributionstore/{faculty_coordinator}',[ContributionController::class,'contributionstore'])->name('class/contributionstore')->can('class/contributionadd');
    Route::get('/class/contributionedit/{faculty_coordinator}/{contribution}',[ContributionController::class,'contributionedit'])->name('class/contributionedit')->can('class/contributionedit');
    Route::post('/class/contributionupdate/{faculty_coordinator}/{contribution}',[ContributionController::class,'contributionupdate'])->name('class/contributionupdate')->can('class/contributionedit');
    Route::get('/class/contributiondelete/{faculty_coordinator}/{contribution}',[ContributionController::class,'contributiondelete'])->name('class/contributiondelete')->can('class/contributiondelete');
    Route::get('/history/historylist/{faculty_coordinator}',[ContributionController::class,'historylist'])->name('history/historylist')->can('history/historylist');
    
//MANAGER
    //Post List
    Route::get('manager/allpost/list',[ManagerController::class,'list']);
    Route::get('/allpost/list',[ManagerController::class,'list'])->name('allpost/list')->can('allpost/list');

    //Download
    Route::post('manager/post/contributionaction',[ContributionController::class,'contributionaction'])->name('manager/contributionaction');
    Route::get('manager/post/viewfile/{contribution}', [ContributionController::class, 'viewfile'])->name('manager/viewfile');
});

