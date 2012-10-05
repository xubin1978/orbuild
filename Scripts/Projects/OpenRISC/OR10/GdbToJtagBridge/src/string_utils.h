
#ifndef STRING_UTILS_H_INCLUDED
#define STRING_UTILS_H_INCLUDED

#include <string>

std::string format_msg ( const char * format_str, ... );
std::string format_errno_msg ( int errno_val,
                               const char * prefix_msg_fmt,
                               ... );

std::string ip_address_to_text ( const struct in_addr * addr );

bool str_starts_with ( const std::string * str, const std::string * prefix );
bool str_remove_prefix ( std::string * str, const std::string *  prefix );

#endif  // Include this header only once.
