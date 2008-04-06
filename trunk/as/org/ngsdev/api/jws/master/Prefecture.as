package org.ngsdev.api.jws.master {
	import org.ngsdev.api.jws.*;
	import org.ngsdev.api.jws.master.*;
	import flash.events.Event;
	public class Prefecture extends Area {
		function Prefecture(x:XML) {
			super(x);
			default xml namespace = new Namespace("jws");
			for each (var a:XML in x.LargeArea) {
				areas.push(new LargeArea(a));
			}
		}
	}
}