package codequalitychecker;

class SearchFile implements Comparable<SearchFile>
{
	public String path;
	public long date;

	public SearchFile(String path,long date)
	{
		this.path=path;
		this.date=date;
	}

	@Override
	public String toString()
	{
		return Long.toString(this.date);
	}

	public int compareTo(SearchFile other)
	{
		return other.date<this.date?-1:1;
	}
}
