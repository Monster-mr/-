#include <SFML/Window.hpp>
#include <SFML/OpenGL.hpp>

int main()
{
	
	sf::Window window(sf::VideoMode(800, 600), "OpenGL");

	// it works out of the box
	glEnable(GL_TEXTURE_2D);

	return 0;
}