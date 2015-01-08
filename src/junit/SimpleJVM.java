package junit;

/**
 * 检测当前JVM内存使用情况：JVM的内存使用情况而不是操作系统的内存
 * @author iXueping
 *
 */
public class SimpleJVM 
{
	public static void main(String[] args) 
	{
		/*
		 * maxMemory()这个方法返回的是java虚拟机（这个进程）能构从操作系统那里挖到的最大的内存，以字节为单位，
		 * 如果在运行java程序的时候，没有添加-Xmx参数，那么就是64兆，也就是说maxMemory()返回的大约是64*1024*1024字节，
		 * 这是java虚拟机默认情况下能从操作系统那里挖到的最大的内存。如果添加了-Xmx参数，将以这个参数后面的值为准，
		 * 例如java -cp ClassPath -Xmx512m ClassName，那么最大内存就是512*1024*0124字节。
		 * 
		 * totalMemory()这个方法返回的是java虚拟机现在已经从操作系统那里挖过来的内存大小，也就是java虚拟机这个进程当时所占用的所有内存。
		 * 如果在运行java的时候没有添加-Xms参数，那么，在java程序运行的过程的，内存总是慢慢的从操作系统那里挖的，基本上是用多少挖多少，
		 * 直挖到maxMemory()为止，所以totalMemory()是慢慢增大的。如果用了-Xms参数，
		 * 程序在启动的时候就会无条件的从操作系统中挖-Xms后面定义的内存数，然后在这些内存用的差不多的时候，再去挖。
		 * 
		 * freeMemory()是什么呢，刚才讲到如果在运行java的时候没有添加-Xms参数，那么，在java程序运行的过程的，
		 * 内存总是慢慢的从操作系统那里挖的，基本上是用多少挖多少，但是java虚拟机100％的情况下是会稍微多挖一点的，
		 * 这些挖过来而又没有用上的内存，实际上就是freeMemory()，所以freeMemory()的值一般情况下都是很小的，
		 * 但是如果你在运行java程序的时候使用了-Xms，这个时候因为程序在启动的时候就会无条件的从操作系统中挖-Xms后面定义的内存数，
		 * 这个时候，挖过来的内存可能大部分没用上，所以这个时候freeMemory()可能会有些JVM堆大小的调整
		 */
		System.out.println("JVM MAX MEMORY: " + Runtime.getRuntime().maxMemory()/1024/1024+"M");
		System.out.println("JVM IS USING MEMORY:" + Runtime.getRuntime().totalMemory()/1024/1024+"M");
		System.out.println("JVM IS FREE MEMORY:" + Runtime.getRuntime().freeMemory()/1024/1024+"M");
	}
}
