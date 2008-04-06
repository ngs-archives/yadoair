package org.ngsdev.api.jws {
	import org.ngsdev.api.jws.*;
	import org.ngsdev.api.jws.master.*;
	import flash.events.*;
	import flash.net.URLRequest;
	import flash.net.URLLoader;
	public class JWS extends EventDispatcher {
		public var apikey = "";
		private var _areas:AreaMaster;
		public function JWS(a:String="") {
			apikey = a;
			getAreas();
		}
		public function getAreas() {
			if(!_areas) {
				_areas = new AreaMaster(this);
				_areas.addEventListener("onInit",function(e:Event) { onAreasInit(); })
			}
		}
		private function onAreasInit() {
			dispatchEvent(new Event("onInit"));
		}
		private function connect() {
			
		}
	}
}