import java.applet.*;

public class Checker extends Applet
{
	// somewhere to keep our details
	private String version;
	private String vendor;
	
	/**
	 * the constructor simply populates the vendor and version vars
	 */
	public Checker()
	{
		version = System.getProperty("java.version");
		vendor = System.getProperty("java.vendor");
	}
	
	/**
	 * get the jvm version
	 * @return jvm verion
	 */
	public String getVersion()
	{
		return this.version;
	}
	
	/**
	 * get the vendor string
	 * @return vendor string
	 */
	public String getVendor()
	{
		return this.vendor;
	}
}
