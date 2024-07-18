@extends('../layouts/backend')
@section('connect-content')
<div class="container-fluid">
    <div class="row">
        <form action="" class="mb-3">
            <span class="d-flex">
                <input type="text" class="form-control" name="keyword" placeholder="Search here..." aria-label="Search here...">
                <input type="submit" name="btn-search" value="Search" class="btn btn-dark">
            </span>
        </form>
        @if ($studentdashboard->count() > 0)
            @foreach($studentdashboard as $student)
                <div class="col-xl-4 col-lg-4 col-md-6">
                    <a href="{{route('student/info', $student->id)}}">
                    <div class="card">
                        <div class="position-relative img-overlay">
                            <img src="{{asset($student->thumbnail)}}" alt="" height="150" width="100%" class="object-fit-cover">
                        </div>
                        <div class="card-body">
                            <div class="text-center">
                                <div class="mx-auto position-absolute z-3 start-50  translate-middle border border-5 border-white" style="top: 40%;">
                                    <img src="{{asset('storage/' . $student->user->profile_photo_path) }}" alt="" class="avatar-md img-fluid">
                                </div>

                                <div class="pt-4">
                                    <h4 class="mb-1">{{$student->user->name}}</h4>
                                    <p class="mb-2">{{$student->name}}</p>
                                    <p class="mb-2">{{$student->semester->name}}</p>
                                    @if($student->status == 'approved')
                                    <span class="badge bg-success">{{$student->status}}</span><br>
                                    @elseif($student->status == 'rejected')
                                    <span class="badge bg-danger">{{$student->status}}</span><br>
                                    @else
                                    <span class="badge bg-warning">{{$student->status}}</span><br>
                                    @endif
                                    <p class="mb-2">{{$student->faculty_coordinator->name}}</p>
                                </div>
                            </div>
                        </div>
                    </div>
                    </a>
                </div>
            @endforeach
        @else
            <div class="col-xl-12 col-lg-12 col-md-12">
                <div class="card">
                    <div class="card-body">
                        <div class="text-center">
                            <div class="pt-4">
                                <h4 class="mb-1">Sorry, We can not find what you want !!!</h4>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        @endif
    </div>
</div> <!-- container -->
@endsection