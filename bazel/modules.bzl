#
# modules.bzl - JavaScript
#

load("@bazel_skylib//rules:build_test.bzl", "build_test")
load("@npm//:defs.bzl", "npm_link_all_packages")
load("@npm//:vite/package_json.bzl", vite = "bin")

def vite_app(name, srcs, deps, dev_deps, **kwargs):
    """ Bazel macro for creating a Vite app """

    npm_link_all_packages()

    node_modules = [ "//:node_modules/%s" % dep for dep in dev_deps ] + [ ":node_modules/%s" % dep for dep in deps ]

    native.alias(name = name, actual = "%s/build" % name, visibility = kwargs.pop("visibility", None))

    vite.vite(
        name = "%s/build" % name,
        srcs = srcs + node_modules,
        args = ["build"],
        chdir = native.package_name(),
        out_dirs = ["dist"],
    )

    vite.vite_binary(
        name = "%s/dev-mode" % name,
        data = srcs + node_modules,
        args = ["dev"],
        chdir = native.package_name(),
    )

    build_test(
        name = "%s/build_test" % name,
        targets = [
            ":build",
            ":type-check",
        ],
    )
