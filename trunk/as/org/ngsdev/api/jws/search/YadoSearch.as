package org.ngsdev.api.jws.search {
	import org.ngsdev.api.jws.JWS;
	import org.ngsdev.api.jws.search.YadoResult;
	import flash.events.*;
	import flash.net.URLRequest;
	import flash.net.URLLoader;
	public class YadoSearch extends EventDispatcher {
		protected static var apiurl:String = "http://jws.jalan.net/APIAdvance/HotelSearch/V1/";
		public static const INIT:String = "onInit";
		private var _urlloader:URLLoader = new URLLoader();
		[ArrayElementType("YadoResult")]
		public var results:Array;
		public var total:int;
		public var parpage:int;
		public var page:int;
		public var nextpage:int;
		public var prevpage:int;
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
			total = parseInt(xml.NumberOfResults);
			parpage = parseInt(xml.DisplayParPage);
			page = parseInt(xml.DisplayFrom);
			nextpage = page + parpage;
			if(nextpage > total) nextpage = -1;
			prevpage = page - parpage;
			if(prevpage < 0) prevpage = -1;
			results = [];
			for each (var a:XML in xml.Hotel) {
				results.push(new YadoResult(a));
			}
			dispatchEvent(new Event(YadoSearch.INIT));
		}
	}
}