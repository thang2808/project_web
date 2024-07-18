@extends('../layouts/backend')
@section('connect-content')
<div class="container-fluid">
    <div class="row">
        <div class="col-12">
            <div class="card">
                @if (session ('success'))
                    <div class="alert alert-success">
                        {{ session('success') }}
                    </div>
                @endif
                <div class="card-body">
                    <form action="" class="mb-3">
                        <span class="d-flex">
                            <input type="text" class="form-control" name="keyword" placeholder="Search here..." aria-label="Search here...">
                            <input type="submit" name="btn-search" value="Search" class="btn btn-dark">
                        </span>
                    </form>
                    <form action="{{url('manager/post/contributionaction')}}" method="POST">
                    @csrf
                    <a href="" class="btn btn-primary">ARTICLE</a>
                    <input type="submit" name="btn-search" value="Download" class="btn btn-primary">
                    <div class="responsive-table-plugin">
                        <div class="table-rep-plugin">
                            <div class="table-responsive" data-pattern="priority-columns">
                                <table id="tech-companies-1" class="table table-striped">
                                    <thead>
                                    <tr>
                                        <th>
                                            <input type="checkbox" name="checkall" id="checkall">
                                        </th>
                                        <th>Num</th>
                                        <th data-priority="1">Student</th>
                                        <th data-priority="3">Title</th>
                                        <th data-priority="3">Info</th>
                                        <th data-priority="1">Class</th>
                                        <th data-priority="1">Category</th>
                                        <th data-priority="3">Status</th>
                                        <th data-priority="3">File</th>
                                        <th data-priority="3">Image</th>
                                    </thead>
                                    <tbody>
                                        @if ($managers->count() > 0)
                                        @php
                                        $t = 1;
                                        @endphp
                                        @foreach ($managers as $manager)
                                        <tr>
                                            <td>
                                                <input type="checkbox" class="list_check" name="list_check[]" value="{{$manager->id}}">
                                            </td>
                                            <td>{{$t++}}</td>
                                            <td>{{$manager->user->name}}</td>
                                            <td>{{$manager->name}}</td>
                                            <td><a href="{{route('student/info',$manager->id)}}" class="btn btn-warning btn-sm rounded-0 text-white" type="button" data-toggle="tooltip" data-placement="top" title="Edit"><i class="fa-solid fa-circle-info"></i></a></td>
                                            <td>{{$manager->faculty_coordinator->name}}</td>
                                            <td>{{$manager->category->name}}</td>
                                            @if($manager->status == 'approved')
                                                <td><span class="badge bg-success">{{$manager->status}}</span></td>
                                            @elseif($manager->status == 'rejected')
                                                <td><span class="badge bg-danger">{{$manager->status}}</span></td>
                                            @else
                                                <td><span class="badge bg-warning">{{$manager->status}}</span></td>
                                            @endif
                                            <td><a href="{{route('manager/viewfile', ['contribution' => $manager]) }}">{{ $manager->upload_file }}</a></td>
                                            <td><img src="{{asset($manager->thumbnail)}}" style="width:100px; height:auto;" alt=""></td>
                                    
                                            {{-- Uncomment the following lines if you want edit and delete buttons --}}
                                            {{-- <td>
                                                <a href="{{route('manager/edit', $manager->id) }}" class="btn btn-success btn-sm rounded-0 text-white" type="button" data-toggle="tooltip" data-placement="top" title="Edit"><i class="fa fa-edit"></i></a>
                                                @if(Auth::id() != $manager->id)
                                                    <a href="{{route('manager/delete', $manager->id)}}" onclick="return confirm('Do you want to delete it???')" class="btn btn-danger btn-sm rounded-0 text-white" type="button" data-toggle="tooltip" data-placement="top" title="Delete"><i class="fa fa-trash"></i></a>
                                                @endif
                                            </td> --}}
                                        </tr>
                                        @endforeach 
                                    @else
                                        <tr class="text-center">
                                            <td colspan="10">Sorry, there is no information available!</td>
                                        </tr>
                                    @endif
                                    
                                    </tbody>
                                </table>
                            </div> <!-- end .table-responsive -->
                            {{-- {{$managers->links()}} --}}

                        </div> <!-- end .table-rep-plugin-->
                    </div> <!-- end .responsive-table-plugin-->
                    </form>
                </div>
            </div> <!-- end card -->
        </div> <!-- end col -->
    </div>
</div>

@endsection