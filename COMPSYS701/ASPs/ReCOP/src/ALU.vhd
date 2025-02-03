------------------------------------------------------------------------------
-- Author's: Dylan Chamberlain, Franklin O'Sullivan
------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.recop_types.all;
use work.opcodes.all;
entity alu is
	port (
		-- ALU operation selection
		alu_op : in alu_op_t;
		-- operands
		operand_a : in bit_16;
		operand_b : in bit_16;
		-- result
		alu_result : out bit_16 := X"0000"
	);
end alu;

architecture combined of alu is
	signal result : bit_16;
begin
	-- perform ALU operation
	process (alu_op, operand_a, operand_b)
	begin
		case alu_op is
			when alu_add =>
				result <= std_logic_vector(unsigned(operand_a) + unsigned(operand_b));
			when alu_sub =>
				result <= std_logic_vector(unsigned(operand_a) - unsigned(operand_b));
			when alu_and =>
				result <= operand_a and operand_b;
			when alu_or =>
				result <= operand_a or operand_b;
			when alu_xor =>
				result <= operand_a xor operand_b;
			when alu_max =>
				if unsigned(operand_a) > unsigned(operand_b) then
					result <= operand_a;
				else
					result <= operand_b;
				end if;
			when alu_sll =>
				result <= std_logic_vector(unsigned(operand_a) sll to_integer(unsigned(operand_b)));
			when alu_srl =>
				result <= std_logic_vector(unsigned(operand_a) srl to_integer(unsigned(operand_b)));
			when alu_a =>
				result <= operand_a;
			when alu_b =>
				result <= operand_b;
			when others =>
				result <= X"0000";
		end case;
	end process;
	alu_result <= result;

end combined;