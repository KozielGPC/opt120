class ApiResponseHandler {
	successResponse(res, msg) {
		var data = {
			status: 1,
			message: msg,
		};
		return res.status(200).json(data);
	}

	successResponseWithData(res, msg, data) {
		var resData = {
			status: 1,
			message: msg,
			data: data,
		};
		return res.status(200).json(resData);
	}

	noContentResponse(res) {
		return res.status(204).json();
	}

	successCreateResponseWithData(res, msg, data) {
		var resData = {
			status: 1,
			message: msg,
			data: data,
		};
		return res.status(201).json(resData);
	}

	internalErrorResponse(res, msg) {
		var data = {
			status: 0,
			message: msg,
		};
		return res.status(500).json(data);
	}

	notFoundResponse(res, msg) {
		var data = {
			status: 0,
			message: msg,
		};
		return res.status(404).json(data);
	}

	validationErrorWithData(res, msg, data) {
		var resData = {
			status: 0,
			message: msg,
			data: data,
		};
		return res.status(400).json(resData);
	}

	validationErrorResponse(res, msg) {
		var resData = {
			status: 0,
			message: msg,
		};
		return res.status(400).json(resData);
	}

	unauthorizedResponse(res, msg) {
		var data = {
			status: 0,
			message: msg,
		};
		return res.status(401).json(data);
	}
}

const responseHandler = new ApiResponseHandler();

module.exports = {
    responseHandler,
}