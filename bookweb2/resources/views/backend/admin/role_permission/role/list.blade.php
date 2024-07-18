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
                    
                        <a href="{{url('admin/role/add')}}" class="btn btn-primary">ADD ROLE</a>
                    <div class="responsive-table-plugin">
                        <div class="table-rep-plugin">
                            <div class="table-responsive" data-pattern="priority-columns">
                                <table id="tech-companies-1" class="table table-striped">
                                    <thead>
                                    <tr>
                                        <th>Num</th>
                                        <th data-priority="1">Code</th>
                                        <th data-priority="3">Role</th>
                                        <th data-priority="1">Description</th>
                                        <th data-priority="1">Create</th>
                                        <th data-priority="3">Updated</th>
                                        <th data-priority="3">Action</th>
                                    </thead>
                                    <tbody>
                                        @if($roles->count() > 0)
                                        @php
                                        $t=1;
                                        @endphp
                                        @foreach($roles as $role)
                                            <tr>
                                                <td>{{$t++}}</td>
                                                <td>{{$role->code}}</td>
                                                <td><a href="{{route('role/edit', $role->id)}}">{{$role->name}}</a></td>
                                                <td>{{$role->description}}</td>
                                                <td>{{$role->created_at}}</td>
                                                <td>{{$role->updated_at}}</td>
                                                <td>
                                                    <a href="{{route('role/edit', $role->id)}}" class="btn btn-success btn-sm rounded-0 text-white" type="button" data-toggle="tooltip" data-placement="top" title="Edit"><i class="fa fa-edit"></i></a>
                                                    <a href="{{route('role/delete', $role->id)}}" onclick="return confirm('Do you want to delete it???')" class="btn btn-danger btn-sm rounded-0 text-white" type="button" data-toggle="tooltip" data-placement="top" title="Delete"><i class="fa fa-trash"></i></a>
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