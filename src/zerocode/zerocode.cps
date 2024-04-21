{
    "name": "zerocode",
    "description": "A C++ project with no code",
    "license": "MIT",
    "version": "1.0.0",
    "default_components": [
        "default"
    ],
    "components": {
        "default": {
            "type": "archive",
            "location": "@prefix@/lib/libzerocode.a",
            "includes": [
                "@prefix@/include"
            ],
            "requires": [],
            "link_flags": [],
            "compile_flags": []
        }
    }
}
