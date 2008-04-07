package org.ngsdev.api.jws {
	import org.ngsdev.api.jws.*;
	import org.ngsdev.api.jws.master.*;
	import flash.events.*;
	import flash.net.URLRequest;
	import flash.net.URLLoader;
	public class JWS extends EventDispatcher {
		public var apikey = "";
		public var areaMaster:AreaMaster;
		public function JWS(a:String="") {
			apikey = a;
		}
		public function getAreas() {
			if(areaMaster) {
				onAreasInit();
			} else {
				areaMaster = new AreaMaster(this);
				areaMaster.addEventListener("onInit",onAreasInit)
			}
		}
		private function onAreasInit(e:Event=null) {
			dispatchEvent(new Event("onAreasInit"));
		}
			
	}
}