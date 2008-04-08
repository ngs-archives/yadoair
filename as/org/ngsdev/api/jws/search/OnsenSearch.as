package org.ngsdev.api.jws.search {
	import org.ngsdev.api.jws.JWS;
	import org.ngsdev.api.jws.search.YadoResult;
	import flash.events.*;
	import flash.net.URLRequest;
	import flash.net.URLLoader;
	public class OnsenSearch extends EventDispatcher {
		protected static var apiurl:String = "http://jws.jalan.net/APICommon/OnsenSearch/V1/";
		public static const INIT:String = "onInit";
		private var _urlloader:URLLoader = new URLLoader();
		[ArrayElementType("OnsenResult")]
		public var results:Array;
		function OnsenSearch() {
		}
		public function search(prm:OnsenSearchParam):void {
			_urlloader.addEventListener(Event.COMPLETE, onLoadXML);
			_urlloader.load(new URLRequest(apiurl+"?key="+JWS.apikey+"&"+prm.queryString));
		}
		private function onLoadXML(e:Event=null) {
			var xml:XML = new XML(_urlloader.data);
			xml.ignoreWhitespace = true;
			default xml namespace = new Namespace("jws");
			results = [];
			for each (var a:XML in xml.Onsen) {
				results.push(new OnsenResult(a));
			}
			dispatchEvent(new Event(OnsenSearch.INIT));
		}
	}
}