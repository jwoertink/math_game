MODES = {
  :easy => 10,
  :hard => 20
}

Shoes.app(title: "Math Helper", width: 760) do
  @true_answer = 0
  @values = []
  @mode = :easy
  @points = 0
  
  stack(width:"40%") do
    title "Math Helper"
  end
  stack(width:"30%") do
    @points_text = para "Points: #{@points}"
  end
  @btn_area = flow do
    button("START") do
      setup_numbers
    end
  end
  
  flow do
    stack(width:50) do
      @num1 = edit_line(width: 30)
    end
    para "+"
    stack(width:50) do
      @num2 = edit_line(width: 30)
    end
    para "+"
    stack(width:50) do
      @num3 = edit_line(width: 30)
    end
    para "="
    stack(width:50) do
      @answer = para
    end
  end
  flow do
    button("ENTER") do
      test_answer
    end
  end
  flow do
    @results = banner('', align: "center", stroke: white)
  end
  
  def test_answer
    if @values[2].text.to_i == @true_answer.to_i
      @results.stroke = green
      @results.text = 'GOOD JOB!'
      @points += 1
      @points_text.text = "Points: #{@points}"
      @btn_area.clear do
        button('RESET') do
          reset_values
        end
      end
    else
      @results.stroke = red
      @results.text = "WRONG. The correct answer was #{@true_answer}."
    end
  end
  
  def setup_numbers
    @values = [@num1, @num2, @num3].sort_by { rand }
    @values[0].text = rand(MODES[@mode])
    @values[1].text = rand(MODES[@mode])
    @answer.text = (@values[0].text.to_i + @values[1].text.to_i + rand(MODES[@mode]))
    @true_answer = (@answer.text.to_i - @values[0].text.to_i - @values[1].text.to_i)
  end
  
  def reset_values
    @results.text = ''
    @num1.text = ''
    @num2.text = ''
    @num3.text = ''
    @answer.text = ''
    setup_numbers
  end
end 