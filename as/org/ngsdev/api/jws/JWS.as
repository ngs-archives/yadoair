package org.ngsdev.api.jws {
	import org.ngsdev.api.jws.*;
	import org.ngsdev.api.jws.master.*;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.net.URLLoader;
	public class JWS {
		public var apikey = "";
		private var _areas:AreaMaster;
		public function JWS(a:String="") {
			apikey = a;
			getAreas()
		}
		public function getAreas() {
			if(!_areas) {
				_areas = new AreaMaster(this);
			}
		}
		private function connect() {
			
		}
	}
}