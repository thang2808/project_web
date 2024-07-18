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
                    <a href="" class="btn btn-primary">CLASS LIST</a>
                    <div class="responsive-table-plugin">
                        <div class="table-rep-plugin">
                            <div class="table-responsive" data-pattern="priority-columns">
                                <table id="tech-companies-1" class="table table-striped">
                                    <thead>
                                    <tr>
                                        <th>Num</th>
                                        <th data-priority="1">Class</th>
                                        <th data-priority="3">Semester</th>
                                        <th data-priority="3">Start_Date</th>
                                        <th data-priority="3">End_Date</th>
                                        <th data-priority="1">Coordinator</th>
                                        {{-- <th data-priority="1">Faculty</th> --}}
                                    </thead>
                                    <tbody>
                                        @if($classes->count() > 0)
                                        @php
                                        $t=1;
                                        @endphp
                                        @foreach ($classes as $class)
                                            <tr>
                                                <th scope="row">{{$t++}}</th>
                                                {{-- <td><a href="{{ route('student/login', ['class' => $class]) }}">{{$class->name ?? 'None'}}</a></td> --}}
                                                <td><a href="{{route('class/contributionlist', ['faculty_coordinator' => $class])}}">{{$class->name ?? 'None'}}</a></td>
                                                <td>{{$class->semester->name}}</td>
                                                <td>{{$class->semester->start_date}}</td>
                                                <td>{{$class->semester->end_date}}</td>
                                                <td>{{$class->user->name}}</td>
                                                {{-- <td>{{$class->faculty->name}}</td> --}}
                                            </tr>
                                        @endforeach
                                        @else
                                            <tr class="text-center">
                                                <td colspan="6">Sorry there is no any information here !!!</td>
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