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
                        <form action="" class="mb-2">
                            <span class="d-flex">
                                <input type="text" class="form-control" name="keyword" placeholder="Search here..." aria-label="Search here...">
                                <input type="submit" name="btn-search" value="Search" class="btn btn-dark">
                            </span>
                        </form>  
                        <a href="{{url('admin/faculty/add')}}" class="btn btn-primary">ADD FACULTY</a>

                    <div class="responsive-table-plugin">
                        <div class="table-rep-plugin">
                            <div class="table-responsive" data-pattern="priority-columns">
                                <table id="tech-companies-1" class="table table-striped">
                                    <thead>
                                    <tr>
                                        <th>Num</th>
                                        <th data-priority="1">ID</th>
                                        <th data-priority="3">Class</th>
                                        <th data-priority="1">Name</th>
                                        <th data-priority="3">Semester</th>
                                        <th data-priority="3">Action</th>
                                    </thead>
                                    <tbody>
                                        @if($faculty_coordinator->count() > 0)
                                        @php
                                        $t=1;
                                        @endphp
                                        @foreach($faculty_coordinator as $class)
                                            <tr>
                                                <td>{{$t++}}</td>
                                                <td>{{$class->user->id}}</td>
                                                <td>{{$class->user->name}}</td>
                                                <td><a href="{{route('faculty/edit', $class->id)}}">{{$class->name}}</a></td>
                                                {{-- <td>{{$class->description}}</td> --}}
                                                <td>{{$class->semester->name}}</td>
                                                <td>
                                                    <a href="{{route('faculty/edit', $class->id)}}" class="btn btn-success btn-sm rounded-0 text-white" type="button" data-toggle="tooltip" data-placement="top" title="Edit"><i class="fa fa-edit"></i></a>
                                                    <a href="{{route('faculty/delete', $class->id)}}" onclick="return confirm('Do you want to delete it???')" class="btn btn-danger btn-sm rounded-0 text-white" type="button" data-toggle="tooltip" data-placement="top" title="Delete"><i class="fa fa-trash"></i></a>
                                                </td>
                                            </tr>
                                        @endforeach
                                        @else
                                            <tr>
                                                <td colspan="7" class="text-center">Sorry there is no any information here !!!</td>
                                            </tr>
                                        @endif
                                    </tbody>
                                </table>
                            </div> <!-- end .table-responsive -->

                        </div> <!-- end .table-rep-plugin-->
                    </div> <!-- end .responsive-table-plugin-->
                </div>
            </div> <!-- end card -->
        </div> <!-- end col -->
    </div>
</div>

@endsection