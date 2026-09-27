VALID_TARGETS 		:= SIM FPGA ASIC
ifeq ($(filter $(BUILD_TARGET),$(VALID_TARGETS)),)
  $(error [Build Error] Invalid BUILD_TARGET = '$(BUILD_TARGET)'. Allowed values: $(VALID_TARGETS))
endif

VALID_FPGA_BOARDS	:= TANG_20K DE10_NANO ICEBREAKER
ifeq ($(filter $(BUILD_TARGET), $(VALID_FPGA_BOARDS)),)
	$(error [Build Error] Invalid BUILD_TARGET = '$(BUILD_TARGET)'. Allowed values: $(VALID_FPGA_BOARDS))
endif

.PHONY: lint-slang clean



clean:

# --- Slang Options ---
SLANG_FLAGS = -F $(INC_FILE)
SLANG_FLAGS += --top $(TOP_MODULE)
SLANG_FLAGS += -Wall
SLANG_FLAGS += --single-unit

lint-slang:
	@mkdir -p $(LOG_DIR)
	@echo "================================================="
	@echo " Running Slang Lint..."
	@echo "================================================="
	@$(SLANG) $(SLANG_FLAGS) 2>&1 | tee $(LOG_FILE)
	@echo "================================================="
	@echo " Linting complete. Log saved to $(LOG_FILE)"