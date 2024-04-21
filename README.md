<!--
Copyright © 2024 Bret Brown
SPDX-License-Identifier: CC0-1.0
-->

# zerocode

## About

This is a C++ library with zero code included[^1].

`zerocode` is useful for nothing, though it might contain value as an experiment in modern and minimal C++ project structure.


## Building

### Dependencies

This project is mainly tested on Ubuntu 22.04, but it should be as portable as CMake is.

This project has zero C or C++ depenendencies.

It does require two tools as build-time dependencies:

-  `cmake`
- `ninja`, `make`, or another CMake-supported build system
  - CMake defaults to "Unix Makefiles" on POSIX systems

### Instructions

#### Basic Build

This project strives to be as normal and simple a CMake project as possible. This build workflow in particular will work, producing a static `zerocode` library, ready to package:

```shell
cmake -B /some/build/dir -S .
cmake --build /some/build/dir
ctest --test-dir /some/build/dir \
  --output-junit build/xunit/results.xml
DESTDIR=/some/staging/dir cmake --install /some/build/dir --component libzerocode-dev --prefix /opt/zerocode
```

If all of those steps complete successfully, you should see the library installed in your staging directory.

An example command:
```shell
find /some/staging/dir -type f
```

You will see files like so:

```
/some/staging/dir
└── opt
    └── zerocode
        ├── include
        │   └── zerocode.hxx
        └── lib
            ├── cmake
            │   └── zerocode
            │       ├── zerocode-noconfig.cmake
            │       └── zerocode.cmake
            ├── libzerocode.a
            └── pkgconfig
                └── zerocode.pc
```

#### Manipulating Warnings

To build this project with warnings enabled, simply use `CMAKE_CXX_FLAGS` [as documented in upstream CMake documentation](https://cmake.org/cmake/help/latest/variable/CMAKE_LANG_FLAGS.html):

```shell
cmake -B /some/build/dir -S . -DCMAKE_CXX_FLAGS='-Werror=all -Wno-error=deprecated-declarations'
```

Otherwise follow the Basic Build workflow as described above.


#### Sanitizers and Coverage Analysis

To build this project with sanitizers enabled, simply use `CMAKE_CXX_FLAGS` [as documented in upstream CMake documentation](https://cmake.org/cmake/help/latest/variable/CMAKE_LANG_FLAGS.html). For instance, to enable an address sanitizer build:

```shell
cmake -B /some/build/dir -S . -DCMAKE_CXX_FLAGS='-sanitize=address'
```

Similarly, but enabling coverage analysis:

```shell
cmake -B /some/build/dir -S . -DCMAKE_CXX_FLAGS='--coverage'
```

Otherwise follow the Basic Build workflow as described above.


## Usage

### From C++

If you *really* want to use `zerocode` from your project (why???), you can include `zerocode.hxx` from your C++ source files

```cxx
#include <zerocode.hxx>
```

`zerocode` supports C++98, C++03, C++11, C++14, C++17, C++20, and C++23. It has no known issues with C++26 or C++29, though there are no compilation toolchains available to test against in those build modes.

Note that `zerocode` is incidentally compatible with most C dialects, but that behavior is not regularly tested and should be considered unsupported.

### From CMake

For consumers using CMake, you will need to use the `zerocode` CMake module to define the `zerocode` CMake target:

```cmake
find_package(zerocode REQUIRED)
```

You will also need to add `zerocode::zerocode` to the link libraries of any libraries or executables that include `zerocode.hxx` in their source or header file.

```cmake
target_link_libraries(yourlib PUBLIC zerocode::zerocode)
```

### From Other Build Systems

Build systems that support `pkg-config` by providing a `zerocode.pc` file. Build systems that support interoperation via `pkg-config` should be able to detect `zerocode` for you automatically.

## Contributing

Please do! Issues and pull requests are appreciated.

Note that adding more C++ code will be out of scope for this project. Changes that further improve or simplify this project given that goal are appreciated. Enhancements to better support packaging ecosystems would also make sense.


## Inspiration

Kelsey Hightower's [kelseyhightower/nocode](https://github.com/kelseyhightower/nocode) parody repository was an inspiration for this project.

[^1]: Please note that *this* project contains strictly more code than `kelseyhightower/nocode`. `zerocode` contains some code in `CMakeLists.txt` files. Objectively, `kelseyhightower/nocode` is a superior project that should be preferred whenever possible.


<!--
Creative Commons Legal Code

CC0 1.0 Universal

    CREATIVE COMMONS CORPORATION IS NOT A LAW FIRM AND DOES NOT PROVIDE
    LEGAL SERVICES. DISTRIBUTION OF THIS DOCUMENT DOES NOT CREATE AN
    ATTORNEY-CLIENT RELATIONSHIP. CREATIVE COMMONS PROVIDES THIS
    INFORMATION ON AN "AS-IS" BASIS. CREATIVE COMMONS MAKES NO WARRANTIES
    REGARDING THE USE OF THIS DOCUMENT OR THE INFORMATION OR WORKS
    PROVIDED HEREUNDER, AND DISCLAIMS LIABILITY FOR DAMAGES RESULTING FROM
    THE USE OF THIS DOCUMENT OR THE INFORMATION OR WORKS PROVIDED
    HEREUNDER.

Statement of Purpose

The laws of most jurisdictions throughout the world automatically confer
exclusive Copyright and Related Rights (defined below) upon the creator
and subsequent owner(s) (each and all, an "owner") of an original work of
authorship and/or a database (each, a "Work").

Certain owners wish to permanently relinquish those rights to a Work for
the purpose of contributing to a commons of creative, cultural and
scientific works ("Commons") that the public can reliably and without fear
of later claims of infringement build upon, modify, incorporate in other
works, reuse and redistribute as freely as possible in any form whatsoever
and for any purposes, including without limitation commercial purposes.
These owners may contribute to the Commons to promote the ideal of a free
culture and the further production of creative, cultural and scientific
works, or to gain reputation or greater distribution for their Work in
part through the use and efforts of others.

For these and/or other purposes and motivations, and without any
expectation of additional consideration or compensation, the person
associating CC0 with a Work (the "Affirmer"), to the extent that he or she
is an owner of Copyright and Related Rights in the Work, voluntarily
elects to apply CC0 to the Work and publicly distribute the Work under its
terms, with knowledge of his or her Copyright and Related Rights in the
Work and the meaning and intended legal effect of CC0 on those rights.

1. Copyright and Related Rights. A Work made available under CC0 may be
protected by copyright and related or neighboring rights ("Copyright and
Related Rights"). Copyright and Related Rights include, but are not
limited to, the following:

  i. the right to reproduce, adapt, distribute, perform, display,
     communicate, and translate a Work;
 ii. moral rights retained by the original author(s) and/or performer(s);
iii. publicity and privacy rights pertaining to a person's image or
     likeness depicted in a Work;
 iv. rights protecting against unfair competition in regards to a Work,
     subject to the limitations in paragraph 4(a), below;
  v. rights protecting the extraction, dissemination, use and reuse of data
     in a Work;
 vi. database rights (such as those arising under Directive 96/9/EC of the
     European Parliament and of the Council of 11 March 1996 on the legal
     protection of databases, and under any national implementation
     thereof, including any amended or successor version of such
     directive); and
vii. other similar, equivalent or corresponding rights throughout the
     world based on applicable law or treaty, and any national
     implementations thereof.

2. Waiver. To the greatest extent permitted by, but not in contravention
of, applicable law, Affirmer hereby overtly, fully, permanently,
irrevocably and unconditionally waives, abandons, and surrenders all of
Affirmer's Copyright and Related Rights and associated claims and causes
of action, whether now known or unknown (including existing as well as
future claims and causes of action), in the Work (i) in all territories
worldwide, (ii) for the maximum duration provided by applicable law or
treaty (including future time extensions), (iii) in any current or future
medium and for any number of copies, and (iv) for any purpose whatsoever,
including without limitation commercial, advertising or promotional
purposes (the "Waiver"). Affirmer makes the Waiver for the benefit of each
member of the public at large and to the detriment of Affirmer's heirs and
successors, fully intending that such Waiver shall not be subject to
revocation, rescission, cancellation, termination, or any other legal or
equitable action to disrupt the quiet enjoyment of the Work by the public
as contemplated by Affirmer's express Statement of Purpose.

3. Public License Fallback. Should any part of the Waiver for any reason
be judged legally invalid or ineffective under applicable law, then the
Waiver shall be preserved to the maximum extent permitted taking into
account Affirmer's express Statement of Purpose. In addition, to the
extent the Waiver is so judged Affirmer hereby grants to each affected
person a royalty-free, non transferable, non sublicensable, non exclusive,
irrevocable and unconditional license to exercise Affirmer's Copyright and
Related Rights in the Work (i) in all territories worldwide, (ii) for the
maximum duration provided by applicable law or treaty (including future
time extensions), (iii) in any current or future medium and for any number
of copies, and (iv) for any purpose whatsoever, including without
limitation commercial, advertising or promotional purposes (the
"License"). The License shall be deemed effective as of the date CC0 was
applied by Affirmer to the Work. Should any part of the License for any
reason be judged legally invalid or ineffective under applicable law, such
partial invalidity or ineffectiveness shall not invalidate the remainder
of the License, and in such case Affirmer hereby affirms that he or she
will not (i) exercise any of his or her remaining Copyright and Related
Rights in the Work or (ii) assert any associated claims and causes of
action with respect to the Work, in either case contrary to Affirmer's
express Statement of Purpose.

4. Limitations and Disclaimers.

 a. No trademark or patent rights held by Affirmer are waived, abandoned,
    surrendered, licensed or otherwise affected by this document.
 b. Affirmer offers the Work as-is and makes no representations or
    warranties of any kind concerning the Work, express, implied,
    statutory or otherwise, including without limitation warranties of
    title, merchantability, fitness for a particular purpose, non
    infringement, or the absence of latent or other defects, accuracy, or
    the present or absence of errors, whether or not discoverable, all to
    the greatest extent permissible under applicable law.
 c. Affirmer disclaims responsibility for clearing rights of other persons
    that may apply to the Work or any use thereof, including without
    limitation any person's Copyright and Related Rights in the Work.
    Further, Affirmer disclaims responsibility for obtaining any necessary
    consents, permissions or other rights required for any use of the
    Work.
 d. Affirmer understands and acknowledges that Creative Commons is not a
    party to this document and has no duty or obligation with respect to
    this CC0 or use of the Work.
-->
