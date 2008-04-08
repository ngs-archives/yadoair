/* ===============================================
*
*  org.ngsdev.api.jws.JWS
*  Jalan WebService for ActionScript3.0
*  http://code.google.com/p/yadoair/
*
*  (C)atsushi nagase http://ngsdev.org/
*  License : Mozilla Public License 1.1
*
=============================================== */
package org.ngsdev.api.jws {
	import org.ngsdev.api.jws.*;
	import org.ngsdev.api.jws.master.*;
	import org.ngsdev.api.jws.search.*;
	import flash.events.*;
	import flash.net.URLRequest;
	import flash.net.URLLoader;
	public class JWS extends EventDispatcher {
		public static var apikey = "";
		public var areaMaster:AreaMaster;
		public var yadoSearch:YadoSearch
		public function JWS(a:String="") {
			apikey = a;
		}
		public function getAreas():void {
			if(areaMaster) {
				onAreasInit();
			} else {
				areaMaster = new AreaMaster();
				areaMaster.addEventListener("onInit",onAreasInit);
			}
		}
		private function onAreasInit(e:Event=null):void {
			dispatchEvent(new Event("onAreasInit"));
		}
		public function getYados(prm:YadoSearchParam,adv:Boolean=false):void {
			if(!yadoSearch) {
				yadoSearch = new YadoSearch();
				yadoSearch.addEventListener("onInit",onGetYados);
			}
			yadoSearch.search(prm,adv);
		}
		private function onGetYados(e:Event=null):void {
			dispatchEvent(new Event("onGetYados"));
		}	
	}
}