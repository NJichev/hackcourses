#include <iostream>
#include <string>

using namespace std;

int main()
{
	string input;
	cout<<"Enter input: "<<endl;
	cin>>input;
	 
	string::iterator it;

	int x=0, y=0;
	int swapped = 1;

	for (it = input.begin(); it < input.end(); it++)
	{
		switch (*it)
		{
		case '~':
			swapped = (-1)*swapped;
			break;
		case '>':
			x = x + swapped;
			break;
		case '<':
			x = x - swapped;
			break;
		case '^':
			y = y + swapped;
			break;
		case 'v':
			y = y - swapped;
			break;
		default:
			cout << "Wrong input!" << endl;
			break;
		}


	}
	cout << "Current (x,y) position is (" << x << ", " << y << ")!" << endl;

	return 0;
}

