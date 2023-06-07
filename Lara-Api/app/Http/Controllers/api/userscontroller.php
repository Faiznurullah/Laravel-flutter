<?php

namespace App\Http\Controllers\api;

use App\Http\Controllers\Controller;
use App\Models\User;
use Illuminate\Http\Request;


class userscontroller extends Controller
{
  
        function get($id = null)
        {
            if (isset($id)) {
                $User = User::findOrFail($id);
                return response()->json(['msg' => 'Data retrieved', 'data' => $User], 200);
            } else {
                $User = User::get();
                return response()->json(['msg' => 'Data retrieved', 'data' => $User], 200);
            }
        }
    
        function store(Request $request)
        {
            $User = User::create($request->all());
            return response()->json(['msg' => 'Data created', 'data' => $User], 201);
        }
    
        function update($id, Request $request)
        {
            $User = User::findOrFail($id);
            $User->update($request->all());
            return response()->json(['msg' => 'Data updated', 'data' => $User], 200);
        }
    
        function destroy($id)
        {
            $User = User::findOrFail($id);
            $User->delete();
            return response()->json(['msg' => 'Data deleted'], 200);
        }
    
    
    
        
    }

