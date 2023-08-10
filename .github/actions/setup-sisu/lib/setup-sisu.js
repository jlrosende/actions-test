/**
 * Copyright (c) HashiCorp, Inc.
 * SPDX-License-Identifier: MPL-2.0
 */

// Node.js core
const os = require("os");
const path = require("path");

// External
const core = require("@actions/core");
const tc = require("@actions/tool-cache");
const io = require("@actions/io");
const github = require("@actions/github");

// arch in [arm, x32, x64...] (https://nodejs.org/api/os.html#os_os_arch)
// return value in [amd64, 386, arm]
function mapArch(arch) {
  const mappings = {
    x32: "386",
    x64: "amd64",
  };
  return mappings[arch] || arch;
}

// os in [darwin, linux, win32...] (https://nodejs.org/api/os.html#os_os_platform)
// return value in [darwin, linux, windows]
function mapOS(os) {
  const mappings = {
    win32: "windows",
  };
  return mappings[os] || os;
}

async function downloadCLI(url) {

  let pathToCLIZip = await tc.downloadTool(url);

  let pathToCLI = "";
  // const pathToCLI = await tc.downloadTool(url);

  core.debug("Extracting Sisu CLI zip file");
  if (os.platform().startsWith("win")) {
    core.debug(`Sisu CLI Download Path is ${pathToCLIZip}`);
    const fixedPathToCLIZip = `${pathToCLIZip}.zip`;
    io.mv(pathToCLIZip, fixedPathToCLIZip);
    core.debug(`Moved download to ${fixedPathToCLIZip}`);
    pathToCLI = await tc.extractZip(fixedPathToCLIZip);
  } else {
    pathToCLI = await tc.extractTar(pathToCLIZip);
  }

  core.debug(`Sisu CLI path is ${pathToCLI}.`);

  if (!pathToCLIZip || !pathToCLI) {
    throw new Error(`Unable to download Sisu from ${url}`);
  }

  return pathToCLI;
}

async function run() {
  try {
    // Gather GitHub Actions inputs
    const version = core.getInput("version");
    const myPAT = core.getInput("token");
    ;
    const octokit = github.getOctokit(myPAT)
    core.debug(octokit)
    const test = await octokit.rest.git.getTag({
      owner: "inditex",
      repo: "lib-sisucommonsgh",
      tag_sha: version
    });

    core.debug(test)

    return

    // Gather OS details
    const osPlatform = os.platform();
    const osArch = os.arch();

    core.debug(`Finding releases for Sisu version ${version}`);

    const platform = mapOS(osPlatform);
    const arch = mapArch(osArch);

    binUrl = `https://github.com/inditex/lib-sisucommonsgh/releases/download/${version}/sisu-${version}-${platform}-${arch}`;
    core.debug(binUrl);

    core.debug(`Downloading Sisu CLI from ${url}`);
    if (os.platform().startsWith("win")) {
      binUrl += ".zip";
    } else {
      binUrl += ".tar.gz";
    }
    const pathToCLI = await downloadCLI(binUrl);

    source = [pathToCLI, `sisu-${version}-${platform}-${arch}`].join(path.sep);
    target = [pathToCLI, `sisu`].join(path.sep);
    core.debug(`Rename ${source} to ${target}`);

    await io.mv(source, target);

    // Add to path
    core.addPath(pathToCLI);

    // return release;
  } catch (error) {
    core.error(error);
    throw error;
  }
}

module.exports = run;