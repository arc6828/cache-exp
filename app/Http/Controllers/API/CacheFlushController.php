<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Cache;

class CacheFlushController extends Controller
{
    public function flush($driver = "all") {
        $drivers = ["file", "database", "redis"];
        if (in_array($driver, $drivers)) {
            // specific driver
            Cache::store($driver)->flush();
            echo "flushed {$driver}";
        } else if($driver == "all"){
            //all
            foreach ($drivers as $item) {
                Cache::store($item)->flush();
            }
            echo "flushed all";
        }
    }
    
    
}
