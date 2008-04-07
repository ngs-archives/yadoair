package org.ngsdev.api.jws.master {
	import org.ngsdev.api.jws.*;
	import org.ngsdev.api.jws.master.*;
	import flash.events.Event;
	public class LargeArea extends Area {
		function LargeArea(x:XML) {
			super(x);
			type = 2;
			default xml namespace = new Namespace("jws");
			for each (var a:XML in x.SmallArea) {
				areas.push(new SmallArea(a));
			}
		}
	}
}