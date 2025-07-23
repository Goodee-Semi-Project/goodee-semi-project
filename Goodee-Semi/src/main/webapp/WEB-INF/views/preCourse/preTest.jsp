<!DOCTYPE html>
<html>
<div class="mt-1" id="test` + i + `">
	<textarea class="content border w-100 rounded p-3 overflow-hidden" name="content` + i + `" id="content` + i + `" oninput="contentInput(` + i + `)" spellcheck="false" style="resize: none;"></textarea>
	
	<div class="d-flex flex-row">
		<div class="d-flex flex-wrap w-75">
			<div class="my-1 mr-1 flex-grow-1">
					<input type="radio" name="quiz` + i + `" value="one">
					<input type="text" class="mx-1" name="one` + i + `">
				</div>
				<div class="my-1 mr-1 flex-grow-1">
					<input type="radio" name="quiz` + i + `" value="two">
					<input type="text" class="mx-1" name="two` + i + `">
				</div>
				<div class="my-1 mr-1 flex-grow-1">
					<input type="radio" name="quiz` + i + `" value="three">
					<input type="text" class="mx-1" name="three` + i + `">
				</div>
				<div class="my-1 mr-1 flex-grow-1">
					<input type="radio" name="quiz` + i + `" value="four">
					<input type="text" class="mx-1" name="four` + i + `">
				</div>
			</div>
		</div>
	</div>
</div>
</html>