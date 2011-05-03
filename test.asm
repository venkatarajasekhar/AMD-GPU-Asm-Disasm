ALU:
	KCACHE_BANK0(1) KCACHE_MODE0.CF_KCACHE_LOCK_1;
	BARRIER;

	LSHR_INT:
		SRC0_SEL.Kcache_bank0(1) SRC1_SEL.ALU_SRC_LITERAL SRC0_CHAN.CHAN_X SRC1_CHAN.CHAN_X;
		WRITE_MASK DST_GPR(2) DST_CHAN.CHAN_X;

	LSHR_INT:
		SRC0_SEL.Kcache_bank0(0) SRC1_SEL.ALU_SRC_LITERAL SRC0_CHAN.CHAN_X SRC1_CHAN.CHAN_X;
		WRITE_MASK DST_GPR(2) DST_CHAN.CHAN_Y;

	LSHR_INT:
		SRC0_SEL.Kcache_bank0(1) SRC1_SEL.ALU_SRC_LITERAL SRC0_CHAN.CHAN_X SRC1_CHAN.CHAN_X LAST;
		WRITE_MASK DST_CHAN.CHAN_Z;
		0x00000002;
		0x00000000;

LOOP_START_DX10:
	ADDR(@1);
	BARRIER;

@2
TC:
	BARRIER;

	FETCH:
		FETCH_TYPE.VTX_FETCH_NO_INDEX_OFFSET BUFFER_ID(173) SRC_GPR(2) SRC_SEL_X.SEL_Y MEGA_FETCH_COUNT(3);
		DST_SEL_X.SEL_MASK DST_SEL_Y.SEL_MASK DST_SEL_Z.SEL_MASK DST_SEL_W.SEL_X USE_CONST_FIELDS NUM_FORMAT_ALL.NUM_FORMAT_NORM;
		MEGA_FETCH;

	FETCH:
		FETCH_TYPE.VTX_FETCH_NO_INDEX_OFFSET BUFFER_ID(173) SRC_SEL_X.SEL_Z MEGA_FETCH_COUNT(15);
		DST_GRP(1) DST_SEL_X.SEL_MASK DST_SEL_Y.SEL_Y DST_SEL_Z.SEL_Z DST_SEL_W.SEL_W DATA_FORMAT(35) NUM_FORMAT_ALL.NUM_FORMAT_NORM;
		MEGA_FETCH;

ALU:
	BARRIER;

	ADD_INT:
		SRC0_SEL.GPR(0) SRC1_SEL.ALU_SRC_LITERAL SRC0_CHAN.CHAN_W SRC1_CHAN.CHAN_X LAST;
		WRITE_MASK DST_GPR(1) DST_CHAN.CHAN_X;
		0xDEADBEEF;
		0x00000000;

MEM_RAT_CACHELESS:
	RAT_ID(11) RAT_INST.EXPORT_RAT_INST_STORE_RAW RAT_INDEX_MODE.CF_INDEX_NONE TYPE(3) RW_GPR(1) INDEX_GPR(2);
	ARRAY_SIZE(4) COMP_MASK(15) VALID_PIXEL_MODE MARK BARRIER;

WAIT_ACK:
	BARRIER;

TC:
	BARRIER;

	FETCH:
		FETCH_TYPE.VTX_FETCH_NO_INDEX_OFFSET BUFFER_ID(173) SRC_GPR(2) SRC_SEL_X.SEL_Y MEGA_FETCH_COUNT(7);
		DST_SEL_X.SEL_MASK DST_SEL_Y.SEL_MASK DST_SEL_Z.SEL_MASK DST_SEL_W.SEL_Y DATA_FORMAT(30) NUM_FORMAT_ALL.NUM_FORMAT_NORM;
		MEGA_FETCH;

ALU:
	BARRIER;

	ADD_INT:
		SRC0_SEL.GPR(0) SRC1_SEL.ALU_SRC_LITERAL SRC0_CHAN.CHAN_W SRC1_CHAN.CHAN_X LAST;
		WRITE_MASK DST_GPR(1) DST_CHAN.CHAN_Y;
		0xEFBEADDE;
		0x00000000;

MEM_RAT_CACHELESS:
	RAT_ID(11) RAT_INST.EXPORT_RAT_INST_STORE_RAW RAT_INDEX_MODE.CF_INDEX_NONE TYPE(3) RW_GPR(1) INDEX_GPR(2);
	ARRAY_SIZE(4) COMP_MASK(15) VALID_PIXEL_MODE MARK BARRIER;

WAIT_ACK:
	BARRIER;

TC:
	BARRIER;

	FETCH:
		FETCH_TYPE.VTX_FETCH_NO_INDEX_OFFSET BUFFER_ID(173) SRC_GPR(2) SRC_SEL_X.SEL_Y MEGA_FETCH_COUNT(11);
		DST_SEL_X.SEL_Z DST_SEL_Y.SEL_MASK DST_SEL_Z.SEL_MASK DST_SEL_W.SEL_MASK DATA_FORMAT(48) NUM_FORMAT_ALL.NUM_FORMAT_NORM;
		MEGA_FETCH;

ALU:
	BARRIER;

	ADD_INT:
		SRC0_SEL.GPR(0) SRC1_SEL.ALU_SRC_LITERAL SRC0_CHAN.CHAN_X SRC1_CHAN.CHAN_X LAST;
		WRITE_MASK DST_GPR(1) DST_CHAN.CHAN_Z;
		0x0000DEAD;
		0x00000000;

MEM_RAT_CACHELESS:
	RAT_ID(11) RAT_INST.EXPORT_RAT_INST_STORE_RAW RAT_INDEX_MODE.CF_INDEX_NONE TYPE(3) RW_GPR(1) INDEX_GPR(2);
	ARRAY_SIZE(4) COMP_MASK(15) VALID_PIXEL_MODE MARK BARRIER;

WAIT_ACK:
	BARRIER;

TC:
	BARRIER;

	FETCH:
		FETCH_TYPE.VTX_FETCH_NO_INDEX_OFFSET BUFFER_ID(173) SRC_GPR(2) SRC_SEL_X.SEL_Y MEGA_FETCH_COUNT(15);
		DST_SEL_X.SEL_MASK DST_SEL_Y.SEL_W DST_SEL_Z.SEL_MASK DST_SEL_W.SEL_MASK DATA_FORMAT(35) NUM_FORMAT_ALL.NUM_FORMAT_NORM;
		MEGA_FETCH;

ALU:
	BARRIER;

	ADD_INT:
		SRC0_SEL.GPR(0) SRC1_SEL.ALU_SRC_LITERAL SRC0_CHAN.CHAN_Y SRC1_CHAN.CHAN_X LAST;
		WRITE_MASK DST_GPR(1) DST_CHAN.CHAN_W;
		0x0000BEEF;
		0x00000000;

MEM_RAT_CACHELESS:
	RAT_ID(11) RAT_INST.EXPORT_RAT_INST_STORE_RAW RAT_INDEX_MODE.CF_INDEX_NONE TYPE(3) RW_GPR(1) INDEX_GPR(2);
	ARRAY_SIZE(4) COMP_MASK(15) VALID_PIXEL_MODE MARK BARRIER;

WAIT_ACK:
	BARRIER;

ALU:
	BARRIER;

	GROUP_BARRIER:
		LAST;

LOOP_END:
	ADDR(@2);
	BARRIER;

NOP: BARRIER;

@1
NOP:
	END_OF_PROGRAM;


end;
