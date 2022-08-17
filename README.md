# Testcase for a setuptools v64 behaviour change with PEP660 style editable installs

## STR:

1. `docker build -t testcase . && docker run --rm -it -e PYTHONPATH=/src testcase hello`

## Expected:

Output to be:

```
Hello!
```

## Actual:

```
Traceback (most recent call last):
  File "/usr/local/bin/hello", line 5, in <module>
    from my_package import hello
ImportError: cannot import name 'hello' from 'my_package' (unknown location)
```

## Notes:

- This testcase uses Python 3.10.6, pip 22.2.2, setuptools 65.0.2, wheel 0.37.1.
- Any of the following prevents the issue from occurring:
  - Downgrading to setuptools <64 (eg: 63.4.3) in the `[build-system]` `requires` of `pyproject.toml`.
  - Removing the `-e PYTHONPATH=/src` from the `docker run` command.
  - Passing `--config-settings editable_mode=compat` to `pip install`.
  - Setting `SETUPTOOLS_ENABLE_FEATURES=legacy-editable` when running `pip install` (uncomment in `Dockerfile` to try it).
  - Adjusting the project layout so that there isn't a directory in the root of the repo with the same name as the package.
