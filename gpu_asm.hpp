/*
 * Copyright 2011 StreamNovation Ltd. All rights reserved.
 * 
 * Redistribution and use in source and binary forms, with or without modification, are
 * permitted provided that the following conditions are met:
 *
 *    1. Redistributions of source code must retain the above copyright notice, this list of
 *       conditions and the following disclaimer.
 * 
 *    2. Redistributions in binary form must reproduce the above copyright notice, this list
 *       of conditions and the following disclaimer in the documentation and/or other materials
 *       provided with the distribution.
 * 
 * THIS SOFTWARE IS PROVIDED BY StreamNovation Ltd. ``AS IS'' AND ANY EXPRESS OR IMPLIED
 * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
 * FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL StreamNovation Ltd. OR
 * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR                                                                                                                    
 * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON                                                                                                                    
 * ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING                                                                                                                          
 * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF                                                                                                                        
 * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.                                                                                                                                                                  
 *                                                                                                                                                                                                             
 * The views and conclusions contained in the software and documentation are those of the                                                                                                                      
 * authors and should not be interpreted as representing official policies, either expressed                                                                                                                   
 * or implied, of StreamNovation Ltd.                                                                                                                                                                          
 *                                                                                                                                                                                                             
 *                                                                                                                                                                                                             
 * Author(s):                                                                                                                                                                                                  
 *          Adam Rak <adam.rak@streamnovation.com>
 *    
 *    
 *    
 */

#ifndef GPU_ASM_HPP
#define GPU_ASM_HPP
#include <vector>
#include <string>
#include "gpu_asm_def.hpp"

class gpu_assembler
{
	gpu_asm::asm_definition asmdef;
	
	struct cf_instruction
	{
		gpu_asm::instruction instr;
		std::vector<gpu_asm::instruction> df_clause;
		int cf_pos; //allocated position of the controlflow
		std::vector<uint32_t> cf_codes;
		int df_pos; //allocated position of the dataflow if present
		std::vector<uint32_t> df_codes;
	};
	
	std::vector<cf_instruction> parsed_instructions;
	std::map<std::string, int> labels;
	
public:
	gpu_assembler(const gpu_asm::asm_definition& asmdef);
	std::vector<uint32_t> assemble(std::string text);
	std::vector<uint32_t> assemble_instruction(gpu_asm::instruction);
	void assemble_literals(std::vector<uint32_t>& data, const std::vector<int>& literal_mapping, gpu_asm::instruction);
	void assemble_fields(std::vector<uint32_t>& data, gpu_asm::instruction);
	gpu_asm::field get_field_def(gpu_asm::instruction, gpu_asm::microcode_field, int& pos);
	uint32_t gen_field_mask(gpu_asm::field, gpu_asm::microcode_field, gpu_asm::instruction);
	uint32_t gen_mask(long value, gpu_asm::field, gpu_asm::instruction);
};

class gpu_disassembler
{
	gpu_asm::asm_definition asmdef;
	std::map<long, int> label_table;
	int indent;
	
	struct tclause
	{
		int addr; // in dword from PGM_START_*
		std::string prefix; //like: TEX_ ALU_ VTX_
		int len; // length
	};
	
	std::vector<tclause> clause_todo;
	
public:
	std::string filter_prefix; //filter by CF_ ALU_ TEX_
	
	gpu_disassembler(const gpu_asm::asm_definition& asmdef);
	std::string disassemble(std::vector<uint32_t> data);
	std::string disassemble_cf(std::vector<uint32_t> data);
	std::string disassemble_clause(std::vector<uint32_t> data, tclause);
	
	gpu_asm::field get_field(std::string format_name, std::string field_name);
	long get_field_value(uint32_t code, gpu_asm::bound bound);
	std::string get_enum_value(uint32_t code, gpu_asm::field);
	int try_tuple_fit(const std::vector<uint32_t>& data, const gpu_asm::microcode_format_tuple& tuple, bool verbose = false);
	std::string parse_tuple(const std::vector<uint32_t>& data, const gpu_asm::microcode_format_tuple& tuple);
	std::string parse_microcode(uint32_t code, const gpu_asm::microcode_format& format, const gpu_asm::microcode_format_tuple& tuple);
	std::string parse_field(uint32_t code, gpu_asm::field, gpu_asm::microcode_format_tuple);
	
	long check_field(const std::vector<uint32_t>& data, const gpu_asm::microcode_format_tuple& tuple, std::string field_name, std::string field_value = "", bool strict = true); //field_value == "": returns the numeric val of the field, otherwise returns a boolean
	
	std::string parse_literals(const std::vector<uint32_t>& data, int offset, int size);
	
	std::string gen_indent(int offset);
	bool has_prefix(std::string str, std::set<std::string> prefix_set) const;
};

namespace gpu_asm
{
	uint32_t byte_mirror(uint32_t);
	std::vector<uint32_t> byte_mirror(std::vector<uint32_t>);
};
#endif
