#include <SFML/System.hpp>
#include <stdlib.h>
#include <iostream>

void func()
{
	// this function is started when thread.launch() is called

	for (int i = 0; i < 10; ++i)
		std::cout << "I'm thread number one" << std::endl;
	     //线程之间不可互相暂停只可自身使用这种将就的方法暂停自己
	    //sf::sleep(sf::milliseconds(10));
}

int main_test()
{
	// create a thread with func() as entry point
	sf::Thread thread(&func);

	// run it
	thread.launch();
	//wait being threa finish
	//thread.wait();

	// the main thread continues to run...

	for (int i = 0; i < 10; ++i)
		std::cout << "I'm the main thread" << std::endl;
	system("pause");

	return 0;
}