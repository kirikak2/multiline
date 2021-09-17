RSpec.describe Multiline::Array do
  describe "#join" do
    it {
text = <<EOF
aaa
bb
c
EOF

text2 = <<EOF
1
22
333
EOF

      array = Multiline::Array.new
      array << Multiline::String.new(text)
      array << Multiline::String.new(text2)

      expect(array.join(",", align: :center).to_s).to eq(
<<EOF
aaa 1  
bb ,22 
c   333
EOF
      )

      expect(array.join(",", align: :top).to_s).to eq(
<<EOF
aaa,1  
bb  22 
c   333
EOF
      )

      expect(array.join(",", align: :bottom).to_s).to eq(
<<EOF
aaa 1  
bb  22 
c  ,333
EOF
      )
    }

    it {
text = <<EOF
aaa
bbb
EOF

text2 = <<EOF
1
22
333
EOF
      array = Multiline::Array.new
      array << Multiline::String.new(text)
      array << Multiline::String.new(text2)

      expect(array.join(",", align: :center).to_s).to eq(
<<EOF
aaa 1  
bbb,22 
    333
EOF
      )

      expect(array.join(",", align: :top).to_s).to eq(
<<EOF
aaa,1  
bbb 22 
    333
EOF
      )

      expect(array.join(",", align: :bottom).to_s).to eq(
<<EOF
    1  
aaa 22 
bbb,333
EOF
      )
    }
  end
end
