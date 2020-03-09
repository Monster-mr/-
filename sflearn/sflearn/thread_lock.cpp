#include <SFML/System.hpp>
#include <iostream>

sf::Mutex mutex;

void func()
{
	mutex.lock();

	for (int i = 0; i < 10; ++i)
		std::cout << "I'm thread number one" << std::endl;

	mutex.unlock();
}

int main()
{
	sf::Thread thread(&func);
	thread.launch();

	mutex.lock();

	for (int i = 0; i < 10; ++i)
		std::cout << "I'm the main thread" << std::endl;

	mutex.unlock();
	system("pause");
	return 0;
}