<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Models\Payload;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Cache;

class CacheController extends Controller
{
    public function none($size, $id = "")
    {
        // $data = Medium::fetch2("samkhok","","");
        $data = Payload::fetch2($size, $id);
        // return $data;
        return json_encode($data, JSON_UNESCAPED_UNICODE);
    }

    public function file($size, $id = "")
    {
        // $data = Medium::fetch("samkhok","","file");
        $data = Payload::fetch($size, "file", $id);
        // return $data;
        return json_encode($data, JSON_UNESCAPED_UNICODE);
    }

    public function mysql($size, $id = "")
    {
        // $data = Medium::fetch("samkhok","","database");
        $data = Payload::fetch($size, "database", $id);
        // return $data;
        return json_encode($data, JSON_UNESCAPED_UNICODE);
    }

    public function redis($size, $id = "")
    {
        // $data = Medium::fetch("samkhok","","redis");
        $data = Payload::fetch($size, "redis", $id);
        // return $data;
        return json_encode($data, JSON_UNESCAPED_UNICODE);
    }
}
