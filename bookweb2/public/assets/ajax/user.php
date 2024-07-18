<?php
use App\Models\User;
use Illuminate\Support\Facades\Auth;

if(isset($_POST['keyword'])) {
    // Process the search query
    $keyword = $_POST['keyword'];

    // Perform your search logic here and echo the search results
    // For demonstration purposes, let's assume $users is your search result
    $filteredUsers = User::where('name', 'LIKE', "%{$keyword}%")
                         ->orWhere('id', 'LIKE', "%{$keyword}%")
                         ->orWhere('email', 'LIKE', "%{$keyword}%")
                         ->get();

    if ($filteredUsers->count() > 0) {
        $t = 1;
        foreach ($filteredUsers as $user) {
            echo "<tr>";
            echo "<td>$t</td>";
            echo "<td>{$user->role->code}-{$user->id}</td>";
            echo "<td>{$user->name}</td>";
            echo "<td>{$user->phone}</td>";
            echo "<td>{$user->email}</td>";
            echo "<td>";
            if ($user->role) {
                echo "<span class='badge bg-success'>{$user->role->name}</span>";
            } else {
                echo "<span class='badge bg-primary'>Not yet!!!</span>";
            }
            echo "</td>";
            echo "<td>";
            echo "<a href='" . route('user/edit', $user->id) . "' class='btn btn-success btn-sm rounded-0 text-white' type='button' data-toggle='tooltip' data-placement='top' title='Edit'><i class='fa fa-edit'></i></a>";
            if (Auth::id() != $user->id) {
                echo "<a href='" . route('user/delete', $user->id) . "' onclick='return confirm(\"Do you want to delete it???\")' class='btn btn-danger btn-sm rounded-0 text-white' type='button' data-toggle='tooltip' data-placement='top' title='Delete'><i class='fa fa-trash'></i></a>";
            }
            echo "</td>";
            echo "</tr>";
        }
    } else {
        echo "<tr>";
        echo "<td colspan='7' class='text-center'>Sorry there is no any information here !!!</td>";
        echo "</tr>";
    }
}
?>
