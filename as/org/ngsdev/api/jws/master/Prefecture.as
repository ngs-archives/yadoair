package org.ngsdev.api.jws.master {
	public class Prefecture extends Area {
		function Prefecture(x:XML) {
			super(x);
			type = 1;
			default xml namespace = new Namespace("jws");
			for each (var a:XML in x.LargeArea) {
				areas.push(new LargeArea(a));
			}
		}
	}
}