<?php

use App\Http\Controllers\API\CacheController;
use App\Http\Controllers\API\CacheFlushController;
use App\Models\Medium;
use App\Models\Payload;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});

Route::prefix('cache')->group(function () {
    Route::get('flush/{driver?}', [CacheFlushController::class, "flush"]);
    Route::get('none/{size}/{id?}', function none($size, $id = "")
    {
        // $data = Medium::fetch2("samkhok","","");
        $data = Payload::fetch2($size, $id);
        return $data;
        // return json_encode($data, JSON_UNESCAPED_UNICODE);
    });
    Route::get('file/{size}/{id?}', function ($size, $id = "")
    {
        // $data = Medium::fetch("samkhok","","file");
        $data = Payload::fetch($size, "file", $id);
        return $data;
        // return json_encode($data, JSON_UNESCAPED_UNICODE);
    });
    Route::get('mysql/{size}/{id?}', function ($size, $id = "")
    {
        // $data = Medium::fetch("samkhok","","database");
        $data = Payload::fetch($size, "database", $id);
        return $data;
        // return json_encode($data, JSON_UNESCAPED_UNICODE);
    });
    Route::get('redis/{size}/{id?}', function ($size, $id = "")
    {
        // $data = Medium::fetch("samkhok","","redis");
        $data = Payload::fetch($size, "redis", $id);
        return $data;
        // return json_encode($data, JSON_UNESCAPED_UNICODE);
    });
    Route::get('json/{size}/{id?}', function ($size, $id = "")
    {
        // $data = Medium::fetch("samkhok","","redis");
        $data = Payload::fetch3($size, "redis", $id);
        return $data;
        // return json_encode($data, JSON_UNESCAPED_UNICODE);
    });
});
