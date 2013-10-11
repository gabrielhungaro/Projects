package
{
	import citrus.core.CitrusEngine;
	
	[SWF(width="1024", height="768")]
	public class HookGame extends CitrusEngine
	{
		public function HookGame()
		{
			var state1:AState = new AState();
			state = state1;
		}
	}
}