package org.ngsdev.api.jws.master {
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