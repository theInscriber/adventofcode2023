#include <iostream>
#include <fstream>
#include <sstream>
#include <string>
#include <iterator>
#include <algorithm>
#include <numeric>
#include <functional>


int main(){
	std::ifstream ifs {"day1.txt"};
	
	std::vector<std::string> calibrations {std::istream_iterator<std::string>{ifs}, std::istream_iterator<std::string>{}};

	auto get_calibration_value = [](std::string const& str){
		std::ostringstream oss {};
		int first {-1};
		int last {-1};

		auto start {str.begin()};

		while(start != str.end()){
			auto it {start++};

			int value {(*it) - '0'};

			if(value < 0 || value > 9) continue;

			if(first < 0) first = value;

			last = value;
		}

		if (last < 0){
			return 0;
		}

		oss << first << last;
		return std::stoi(oss.str());
	};

	int sum {std::transform_reduce(calibrations.begin(), calibrations.end(), 0, std::plus(), get_calibration_value)};


	std::cout << "The answer is: " << sum << std::endl;
	
	return 0;
};
