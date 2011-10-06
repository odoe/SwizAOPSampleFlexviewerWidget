package widgets.swizaopsamples.aspects
{
	import mx.controls.Alert;
	
	import org.swizframework.aop.support.IMethodInvocation;
	import org.swizframework.reflection.BaseMetadataTag;

	public class SecurityAspect
	{
		public function SecurityAspect()
		{
		}
		
		[Around( annotation="PreAuthorize" )]
		public function performAuthorization( invocation:IMethodInvocation, md:BaseMetadataTag ):*
		{
			var requiredRole:String = md.getArg( "requires" ).value;
			var authorized:Boolean = requiredRole == "ADMIN"; // force a security warning for testing
			
			trace( "SecuritAspect running - current required role: ", requiredRole );
			
			if ( authorized ) {
				return invocation.proceed();
			} else {
				Alert.show( "WARNING: Current User must be EDITOR", "Insufficient Priveleges" );
				return null;
			}
		}
	}
}