module seq101(seq_in,
	       clock,
	       reset,
	       det_o);
								 
   parameter IDLE   = 2'b00,
	     STATE1 = 2'b01,
	     STATE2 = 2'b10,
	     STATE3 = 2'b11;

   input seq_in,clock,reset;
   output det_o;

   reg [1:0]state,next_state;

   always@(posedge clock,posedge reset)
      begin
	 if(reset)
	    state <= IDLE;
	 else
	    state <= next_state;
      end
			
   always@(state,seq_in)
      begin
	 case(state)
	    IDLE   : 
                      if(seq_in==1) 
		         next_state=STATE1;
	              else
	                 next_state=IDLE;
	    STATE1 : 
                      if(seq_in==0)
	                 next_state=STATE2;
	              else
	                 next_state=STATE1;
	    STATE2 :
                      if(seq_in==1)
	                 next_state=STATE3;
	              else 
	                 next_state=IDLE;
	    STATE3 : 
                      if(seq_in==1)
	                 next_state=STATE1;
	              else 
	                 next_state=STATE2;
	    default: 
                      next_state=IDLE;
	 endcase
      end

   assign det_o = (state ==  STATE3) ? 1'b1:1'b0;

endmodule

