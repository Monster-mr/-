#include <SFML/Window.hpp>
#include <iostream>
#include <stdlib.h>

int main()
{
	sf::Window window(sf::VideoMode(800, 600), "My window");
	while (window.isOpen())
	{
		// check all the window's events that were triggered since the last iteration of the loop
		sf::Event event;
		while (window.pollEvent(event))
		{
			// "close requested" event: we close the window
			if (event.type == sf::Event::Closed)
				window.close();
			if (event.type == sf::Event::Resized)
			{
				std::cout << "new width: " << event.size.width << std::endl;
				std::cout << "new height: " << event.size.height << std::endl;
			}
		}
	}
	window.create(sf::VideoMode(200, 400), "haha");

	system("pause");

	return 0;
}