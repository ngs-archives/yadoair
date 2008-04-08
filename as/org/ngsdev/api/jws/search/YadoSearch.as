package org.ngsdev.api.jws.search {
	import org.ngsdev.api.jws.*;
	import org.ngsdev.api.jws.search.*;
	import flash.events.*;
	import flash.net.URLRequest;
	import flash.net.URLLoader;
	public class YadoSearch extends EventDispatcher {
		protected static var apiurl:String = "http://jws.jalan.net/APICommon/AreaSearch/V1/";
		private var _urlloader:URLLoader = new URLLoader();
		public var results:Array;
		function YadoSearch() {
		}
		public function search(params:Array,adv:Boolean=false):void {
			_urlloader.addEventListener(Event.COMPLETE, onLoadXML);
			_urlloader.load(new URLRequest(apiurl+"?key="+JWS.apikey));
		}
		private function onLoadXML(e:Event=null) {
			var xml:XML = new XML(_urlloader.data);
			xml.ignoreWhitespace = true;
			default xml namespace = new Namespace("jws");
			results = [];
			for each (var a:XML in xml.Results.Hotel) {
				results.push(new YadoResult(a));
			}
		}
	}
}