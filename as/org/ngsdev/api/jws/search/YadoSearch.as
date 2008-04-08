package org.ngsdev.api.jws.search {
	import org.ngsdev.api.jws.JWS;
	import org.ngsdev.api.jws.search.YadoResult;
	import flash.events.*;
	import flash.net.URLRequest;
	import flash.net.URLLoader;
	public class YadoSearch extends EventDispatcher {
		protected static var apiurl:String = "http://jws.jalan.net/APIAdvance/HotelSearch/V1/";
		private var _urlloader:URLLoader = new URLLoader();
		[ArrayElementType("YadoResult")]
		public var results:Array;
		function YadoSearch() {
		}
		public function search(prm:YadoSearchParam,adv:Boolean=false):void {
			_urlloader.addEventListener(Event.COMPLETE, onLoadXML);
			_urlloader.load(new URLRequest(apiurl+"?key="+JWS.apikey+"&"+prm.queryString));
		}
		private function onLoadXML(e:Event=null) {
			var xml:XML = new XML(_urlloader.data);
			xml.ignoreWhitespace = true;
			default xml namespace = new Namespace("jws");
			results = [];
			for each (var a:XML in xml.Hotel) {
				results.push(new YadoResult(a));
			}
		}
	}
}