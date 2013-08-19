SCRIPTS_DIR=scripts
BUILD_SCRIPT=build.sh

ext:
	@pushd $(SCRIPTS_DIR) && ./$(BUILD_SCRIPT) && popd;
