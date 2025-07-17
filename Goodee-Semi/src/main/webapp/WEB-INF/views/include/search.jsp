<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

				<div class="advance-search">
					<div class="container">
						<div class="row justify-content-center">
							<div class="col-lg-12 col-md-12 align-content-center">
								<form id="searchCourseForm">
									<div class="form-row">
										<div class="form-group col-3">
											<input type="text" class="form-control my-2" id="searchByTitle" name="searchByTitle" placeholder="교육과정">
											<input type="checkbox" name="onlyAvailable" value="Y"> 수강 가능 과정만 검색하기
										</div>
										
										<div class="form-group col-3">
											<input type="text" class="form-control my-2" id="searchByTrainer" name="searchByTrainer" placeholder="훈련사">
										</div>
										
										<div class="form-group col-2">
											<input type="text" class="form-control my-2" id="searchByTag" name="searchByTag" placeholder="태그">
										</div>
										
										<div class="form-group col-2">
											<button type="submit" class="btn btn-primary active mt-1 w-100">검색</button>
										</div>
										
										<div class="form-group col-2">
											<button type="button" id="searchReset" class="btn btn-primary active mt-1 w-100">전체 조회</button>
										</div>
									</div>
								</form>
							</div>
						</div>
					</div>
				</div>